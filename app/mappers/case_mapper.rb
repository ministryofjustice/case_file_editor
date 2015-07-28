class CaseMapper < Yaks::Mapper
  attributes \
    :pti_urn,
    :type,
    :associated_case_urns,
    :version,
    :brief_description_of_case,
    :defendants,
    :witnesses,
    :common_law_disclosure,
    :multimedia_evidence,
    :is_hearsay,
    :hearsay_details,
    :expert_evidence,
    :pca_cps,
    :safe_guarding_assessment,
    :property,
    :officer_in_the_case,
    :signatory_name,
    :date,
    :signatory_rank

  attribute :case_markers do
    object.case_markers.value
  end

  attribute :likely_case_progression do
    object.likely_case_progression.value
  end

  attribute :test_code do
    object.test_code.value
  end
end
