class GenericOffenceCollection < OffenceCollection
  attribute :generic_offences, Array[GenericOffence]
  attribute :type, String, writer: :private, default: 'GenericOffences'

  def not_guilty_anticipated_plea?
    generic_offences.any?(&:not_guilty_anticipated_plea?)
  end

  alias_method :offences, :generic_offences

  def validate_property_ids(available_ids)
    generic_offences.each do |offence|
      offence.validate_property_ids available_ids
    end
  end
end
