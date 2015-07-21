class OrganisationName < Name
  include Virtus.model

  attribute :organisation_name, String
end
