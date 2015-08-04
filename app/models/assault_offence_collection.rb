class AssaultOffenceCollection < OffenceCollection
  attribute :assault_offences, Array[AssaultOffence]
  attribute :type, String, writer: :private, default: 'AssaultOffences'
end
