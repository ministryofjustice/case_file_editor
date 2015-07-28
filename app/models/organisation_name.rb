class OrganisationName < Name
  include Virtus.model
  include ActiveModel::Validations

  attribute :organisation_name, String
end
