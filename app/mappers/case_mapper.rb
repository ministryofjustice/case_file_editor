class CaseMapper < Yaks::Mapper
  attributes \
    :pti_urn,
    :type,
    :associated_case_urns,
    :version,
    :case_markers,
    :brief_description_of_case,
    :likely_case_progression,
    :is_hearsay,
    :hearsay_details,
    :expert_evidence,
    :test_code,
    :pca_cps,
    :date,
    :signatory_rank
  has_many :defendants
  has_many :witnesses
  has_one :common_law_disclosure
  has_many :multimedia_evidence
  has_one :safeguarding_assessment
  has_many :property
  has_one :officer_in_the_case
  has_one :signatory_name
end
