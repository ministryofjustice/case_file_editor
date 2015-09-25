class Case
  include Virtus.model
  include ActiveModel::Validations

  VALID_URN = /\A[A-Z]{4}\d{5}\d{2}(-[A-Z]{2})?\z/
  MAX_1200_WORDS = /\A\s*(\S+\s*){1,1200}\z/

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
  # TODO: If witness is 10 or under, Case must be marked as
  #       YoungWitnessInitiative
  # TODO: If a Victim is over 60 years old, Case must be marked as
  #       CrimeAgainstAnOlderPerson

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
    presence: {
      message: 'must be present when there is a guilty anticipated plea'
    },
    if: :anticipated_guilty_plea?
  validates :likely_case_progression,
    absence: {
      message: 'must be absent when there is no guilty anticipated plea'
    },
    unless: :anticipated_guilty_plea?

  attribute :multimedia_evidence, Array[Mme]
  validates :multimedia_evidence, array_uniqueness: true

  attribute :is_hearsay, Virtus::Attribute::Boolean
  validates :is_hearsay,
    inclusion: {
      in: [true, false],
      message: 'must be present when there is a guilty anticipated plea'
    },
    if: :anticipated_guilty_plea?
  validates :is_hearsay,
    inclusion: {
      in: [nil],
      message: 'must be absent when there is no guilty anticipated plea'
    },
    unless: :anticipated_guilty_plea?

  attribute :hearsay_details, String
  validates :hearsay_details,
    presence: {
      message: 'must be present when case is hearsay'
    },
    if: :is_hearsay
  validates :hearsay_details,
    absence: {
      message: 'must be absent when case is not hearsay'
    },
    unless: :is_hearsay

  attribute :expert_evidence, Virtus::Attribute::Boolean
  validates :expert_evidence, inclusion: { in: [true, false] }

  attribute :test_code, String
  validates :test_code,
    inclusion: { in: Enumerations::TestCode }

  attribute :pca_cps, Virtus::Attribute::Boolean
  validates :pca_cps, inclusion: { in: [true, false] }

  attribute :safeguarding_assessment, SafeguardingAssessment
  validates :safeguarding_assessment,
    presence: {
      message: 'must be present when case is domestic violence'
    },
    if: :domestic_violence?
  validates :safeguarding_assessment,
    absence: {
      message: 'must be absent when case is not domestic violence'
    },
    unless: :domestic_violence?

  attribute :property, Array[Property]
  validates :property, array_uniqueness: true

  attribute :officer_in_the_case, PersonName
  validates :officer_in_the_case, presence: true

  attribute :signatory_name, PersonName
  validates :signatory_name, presence: true

  attribute :date, Date
  validates :date, presence: true

  attribute :signatory_rank, String
  validates :signatory_rank, presence: true
  # TODO: Validate against CJSE Data Standards Section 3.108

  def domestic_violence?
    case_markers.include?('DV')
  end

  def anticipated_guilty_plea?
    defendants.any?(&:anticipated_guilty_plea?)
  end
end
