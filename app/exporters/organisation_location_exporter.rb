class OrganisationLocationExporter < GenericExporter
  attributes \
    :ou_top_level_name,
    :ou_second_level_name,
    :ou_third_level_name,
    :ou_bottom_level_name
end
