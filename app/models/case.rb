class Case
  include Virtus.model
  include ActiveModel::Validations

  attribute :pti_urn, String
  attribute :type, String, writer: :private, default: 'FirstHearingDCF'
  attribute :associated_case_urns, Array[String]
  attribute :version, Integer
  attribute :case_markers, Array[String]
  validates :case_markers,
    array_inclusion: { in: Enumerations::CaseMarker }
  attribute :brief_description_of_case, String
  attribute :defendants, Array[Defendant]
  attribute :witnesses, Array[Witness]
  attribute :common_law_disclosure, CommonLaw
  attribute :likely_case_progression, String
  validates :likely_case_progression,
    inclusion: { in: Enumerations::LikelyCaseProgression }
  attribute :multimedia_evidence, Array[Mme]
  attribute :is_hearsay, Boolean
  attribute :hearsay_details, String
  attribute :expert_evidence, Boolean
  attribute :test_code, String
  validates :test_code,
    inclusion: { in: Enumerations::TestCode }
  attribute :pca_cps, String
  attribute :safeguarding_assessment, SafeguardingAssessment
  attribute :property, Array[Property]
  attribute :officer_in_the_case, PersonName
  attribute :signatory_name, PersonName
  attribute :date, Date
  attribute :signatory_rank, String
end
