class OrganisationName < Name
  include Virtus.model
  include ActiveModel::Validations

  attribute :organisation_name, String
  validates :organisation_name, presence: true
end
