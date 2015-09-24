class GenericOffenceCollection < OffenceCollection
  attribute :generic_offences, Array[GenericOffence]
  attribute :type, String, writer: :private, default: 'GenericOffences'

  def anticipated_guilty_plea?
    generic_offences.any?(&:anticipated_guilty_plea?)
  end
end
