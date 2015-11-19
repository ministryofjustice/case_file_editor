class AssaultOffenceCollection < OffenceCollection
  attribute :assault_offences, Array[AssaultOffence], relation: true
  attribute :type, String, writer: :private, default: 'AssaultOffences'

  def not_guilty_anticipated_plea?
    assault_offences.any?(&:not_guilty_anticipated_plea?)
  end

  alias_method :offences, :assault_offences
end
