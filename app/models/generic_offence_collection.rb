class GenericOffenceCollection < OffenceCollection
  attribute :generic_offences, Array[GenericOffence], relation: true
  attribute :type, String, writer: :private, default: 'GenericOffences'

  def not_guilty_anticipated_plea?
    generic_offences.any?(&:not_guilty_anticipated_plea?)
  end

  alias_method :offences, :generic_offences
end
