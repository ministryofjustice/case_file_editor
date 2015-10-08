class OrganisationName < Name
  include BasicModel

  attribute :organisation_name, String
  validates :organisation_name, presence: true
end
