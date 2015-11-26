class FirstHearingCaseFileExporter < GenericExporter
  attributes \
    :schema_version,
    :pti_urn,
    :type,
    :associated_case_urns,
    :version,
    :case_markers,
    :brief_description_of_case,
    :defendants,
    :witnesses,
    :common_law_disclosure,
    :likely_case_progression,
    :multimedia_evidence,
    :is_hearsay,
    :hearsay_details,
    :expert_evidence,
    :test_code,
    :pca_cps,
    :property,
    :officer_in_the_case,
    :signatory_name,
    :date
end
