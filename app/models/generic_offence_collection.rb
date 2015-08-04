class GenericOffenceCollection < OffenceCollection
  attribute :generic_offences, Array[GenericOffence]
  attribute :type, String, writer: :private, default: 'GenericOffences'
end
