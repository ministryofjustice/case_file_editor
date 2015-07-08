class OrganisationVictim < Victim
  attribute :type, String, writer: :private, default: 'OrganisationVictim'

  attribute :name, OrganisationName
end
