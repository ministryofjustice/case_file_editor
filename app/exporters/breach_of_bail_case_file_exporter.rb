class BreachOfBailCaseFileExporter < GenericExporter
  attributes \
    :schema_version,
    :pti_urn,
    :type,
    :associated_case_urns,
    :version,
    :brief_description_of_case,
    :defendants,
    :witnesses,
    :multimedia_evidence,
    :officer_in_the_case,
    :signatory_name,
    :date
end
