class OrganisationLocation
  include Virtus.model

  attribute :ou_top_level_name, String
  attribute :ou_second_level_name, String
  attribute :ou_third_level_name, String
  attribute :ou_bottom_level_name, String
end
