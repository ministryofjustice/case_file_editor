class OrganisationVictim < Victim
  include Person

  attribute :type, String, writer: :private, default: 'OrganisationVictim'

  attribute :name, OrganisationName
  validates :name, presence: true
end
