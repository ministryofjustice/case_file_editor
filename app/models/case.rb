class Case
  include Virtus.model

  attribute :pti_urn, String
  attribute :type, String, writer: :private, default: 'CaseFile'
  attribute :associated_case_urns, Array[String]
  attribute :version, Integer
  attribute :case_markers, Array[CaseMarker]
  attribute :brief_description_of_case, String
  attribute :defendants, Array[Defendant]
  attribute :witnesses, Array[Witness]
  attribute :common_law_disclosure, CommonLaw
  attribute :likely_case_progression, LikelyCaseProgression
  attribute :multimedia_evidence, Array[Mme]
  attribute :is_hearsay, Boolean
  attribute :hearsay_details, String
  attribute :expert_evidence, Boolean
  attribute :test_code, TestCode
  attribute :pca_cps, String
  attribute :safe_guarding_assessment, SafeguardingAssessment
  attribute :property, Array[Property]
  attribute :officer_in_the_case, PersonName
  attribute :signatory_name, PersonName
  attribute :date, Date
  attribute :signatory_rank, String
end
