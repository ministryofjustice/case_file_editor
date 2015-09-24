class AssaultOffenceCollection < OffenceCollection
  attribute :assault_offences, Array[AssaultOffence]
  attribute :type, String, writer: :private, default: 'AssaultOffences'

  def anticipated_guilty_plea?
    assault_offences.any?(&:anticipated_guilty_plea?)
  end
end
