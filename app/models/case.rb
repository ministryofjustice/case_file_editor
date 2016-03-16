class Case
  include BasicModel
  include Virtus.relations(as: :case_file)

  VALID_URN = /\A[0-9]{2}[A-Z]{2}[0-9]{5}[0-9]{2}(-[A-Z]{2})?\z/
  MAX_1200_WORDS = /\A\s*(\S+\s*){1,1200}\z/
  YOUNG_WITNESS_MAX_AGE = 10
  OLDER_VICTIM_MIN_AGE = 60

  attribute :pti_urn, String
  validates :pti_urn,
    format: { with: VALID_URN }

  attribute :type, String, writer: :private

  attribute :associated_case_urns, Array[String]
  validates :associated_case_urns,
    array_format: { with: VALID_URN },
    array_uniqueness: true

  attribute :version, Integer, default: 1
  validates :version, numericality: { greater_than_or_equal_to: 1 }

  attribute :brief_description_of_case, String
  validates :brief_description_of_case, format: { with: MAX_1200_WORDS }

  attribute :defendants, Array[Defendant], relation: true

  attribute :witnesses, Array[Witness], relation: true
  validates :witnesses,
    length: { minimum: 1 },
    array_uniqueness: true

  attribute :officer_in_the_case, OfficerName
  validates :officer_in_the_case, presence: true

  attribute :signatory_name, OfficerName
  validates :signatory_name, presence: true

  attribute :date, Date
  validates :date, presence: true

  attribute :case_markers, Array[String]
  attribute :common_law_disclosure, CommonLawNotForDisclosure
  attribute :likely_case_progression, String
  attribute :multimedia_evidence, Array[Mme], relation: true
  attribute :is_hearsay, Virtus::Attribute::Boolean
  attribute :hearsay_details, String
  attribute :expert_evidence, Virtus::Attribute::Boolean
  attribute :test_code, String
  attribute :pca_cps, Virtus::Attribute::Boolean
  attribute :property, Array[Property], relation: true

  def domestic_violence_case?
    case_markers.include?('DomesticViolence')
  end

  def not_guilty_anticipated_plea?
    defendants.any?(&:def_not_guilty_anticipated_plea?)
  end

  def young_witness?
    return false unless date
    witnesses.any? { |w|
      w.respond_to?(:age) &&
        w.age(date) &&
        w.age(date) <= YOUNG_WITNESS_MAX_AGE
    }
  end

  def older_victim?
    return false unless date
    victims.any? { |v|
      v.respond_to?(:age) &&
        v.age(date) &&
        v.age(date) >= OLDER_VICTIM_MIN_AGE
    }
  end

  def victims
    witnesses.select { |w| w.is_a?(Victim) }
  end

  def defendant_names
    defendants.map(&:name)
  end

  def property_ids
    property.map(&:property_id)
  end

  def mme_ids
    multimedia_evidence.map(&:id)
  end

  def witness_ids
    witnesses.map(&:witness_id)
  end
end
