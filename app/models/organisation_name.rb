class OrganisationName < Name
  include BasicModel

  attribute :type, String
  validates :type, presence: true

  attribute :organisation_name, String
  validates :organisation_name, presence: true
end
