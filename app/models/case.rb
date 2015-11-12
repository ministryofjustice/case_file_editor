class Case
  include BasicModel

  VALID_URN = /\A[0-9]{2}[A-Z]{2}[0-9]{5}[0-9]{2}(-[A-Z]{2})?\z/
  MAX_1200_WORDS = /\A\s*(\S+\s*){1,1200}\z/
  YOUNG_WITNESS_MAX_AGE = 10
  OLDER_VICTIM_MIN_AGE = 60

  attribute :schema_version, String
  validates :schema_version, presence: true

  attribute :pti_urn, String
  validates :pti_urn,
    format: { with: VALID_URN }

  attribute :type, String, writer: :private, default: 'FirstHearingDCF'

  attribute :associated_case_urns, Array[String]
  validates :associated_case_urns,
    array_format: { with: VALID_URN },
    array_uniqueness: true

  attribute :version, Integer, default: 1
  validates :version, numericality: { greater_than_or_equal_to: 1 }

  attribute :case_markers, Array[String]
  validates :case_markers,
    array_inclusion: { in: Enumerations::CaseMarker }
  validates :case_markers,
    array_membership: { of: 'YoungWitnessInitiative' },
    if: :young_witness?
  validates :case_markers,
    array_membership: { of: 'CrimeAgainstAnOlderPerson' },
    if: :older_victim?

  attribute :brief_description_of_case, String
  validates :brief_description_of_case, format: { with: MAX_1200_WORDS }

  attribute :defendants, Array[Defendant]
  validates :defendants,
    length: { minimum: 1 },
    array_uniqueness: true

  attribute :witnesses, Array[Witness]
  validates :witnesses,
    length: { minimum: 1 },
    array_uniqueness: true

  attribute :common_law_disclosure, CommonLaw
  validates :common_law_disclosure, presence: true

  attribute :likely_case_progression, String
  validates :likely_case_progression,
    inclusion: { in: Enumerations::LikelyCaseProgression, allow_nil: true }
  validates :likely_case_progression,
    presence: true,
    if: :not_guilty_anticipated_plea?
  validates :likely_case_progression,
    absence: true,
    unless: :not_guilty_anticipated_plea?

  attribute :multimedia_evidence, Array[Mme]
  validates :multimedia_evidence, array_uniqueness: true

  attribute :is_hearsay, Virtus::Attribute::Boolean
  validates :is_hearsay,
    boolean_presence: true,
    if: :not_guilty_anticipated_plea?
  validates :is_hearsay,
    boolean_absence: true,
    unless: :not_guilty_anticipated_plea?

  attribute :hearsay_details, String
  validates :hearsay_details,
    presence: true,
    if: :is_hearsay
  validates :hearsay_details,
    absence: true,
    unless: :is_hearsay

  attribute :expert_evidence, Virtus::Attribute::Boolean
  validates :expert_evidence, boolean_presence: true

  attribute :test_code, String
  validates :test_code,
    inclusion: { in: Enumerations::TestCode }

  attribute :pca_cps, Virtus::Attribute::Boolean
  validates :pca_cps, boolean_presence: true

  attribute :property, Array[Property]
  validates :property, array_uniqueness: true

  attribute :officer_in_the_case, PersonName
  validates :officer_in_the_case, presence: true

  attribute :officer_in_the_case_rank, String
  validates :officer_in_the_case_rank, presence: true
  # TODO: Validate against CJSE Data Standards Section 3.108

  attribute :officer_in_the_case_collar_number, String
  validates :officer_in_the_case_collar_number, presence: true

  attribute :signatory_name, PersonName
  validates :signatory_name, presence: true

  attribute :date, Date
  validates :date, presence: true

  attribute :signatory_rank, String
  validates :signatory_rank, presence: true
  # TODO: Validate against CJSE Data Standards Section 3.108

  attribute :signatory_collar_number, String
  validates :signatory_collar_number, presence: true

  def domestic_violence?
    case_markers.include?('DomesticViolence')
  end

  def not_guilty_anticipated_plea?
    defendants.any?(&:not_guilty_anticipated_plea?)
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

private

  def validate_compensation_application_defendant_names
    available_names = defendants.map(&:name)
    victims.each do |victim|
      victim.compensation_applications.each do |ca|
        invalid_names = ca.defendant_names - available_names
        if invalid_names.any?
          ca.errors.add :defendant_names, :match_defendant
        end
      end
    end
  end
  validate :validate_compensation_application_defendant_names

  def validate_defendants_by_age
    defendants.each do |defendant|
      defendant.validate_by_age(date)
    end
  end
  validate :validate_defendants_by_age

  def validate_dv_victims
    names = victims.map(&:name)
    defendants.each do |defendant|
      defendant.validate_dv_victims names
    end
  end
  validate :validate_dv_victims

  def validate_domestic_violence_specific
    [*defendants, *victims].each do |item|
      item.validate_domestic_violence_specific(domestic_violence?)
    end
  end
  validate :validate_domestic_violence_specific

  def validate_gap_specific
    if not_guilty_anticipated_plea?
      witnesses.each(&:validate_as_ngap)
    else
      witnesses.each(&:validate_as_gap)
    end
  end
  validate :validate_gap_specific

  def validate_unique_ids
    validate_unique_on_collection multimedia_evidence, :id
    validate_unique_on_collection witnesses, :witness_id
    validate_unique_on_collection property, :property_id
  end
  validate :validate_unique_ids

  def validate_mme_response_ids
    ids = multimedia_evidence.map(&:id)
    defendants.each do |defendant|
      defendant.validate_mme_response_ids ids
    end
  end
  validate :validate_mme_response_ids

  def validate_property_ids
    available_ids = property.map(&:property_id)
    defendants.each do |defendant|
      defendant.validate_property_ids available_ids
    end
  end
  validate :validate_property_ids

  def validate_no_mme_not_recorded_if_mme
    if multimedia_evidence.any?
      defendants.each(&:validate_no_mme_not_recorded)
    end
  end
  validate :validate_no_mme_not_recorded_if_mme

  def validate_unique_on_collection(collection, field)
    ids = collection.map(&field).compact
    collection.
      select { |e| ids.count(e.send(field)) > 1 }.
      each do |item|
        item.errors.add field, :unique_within_case_file
      end
  end
end
