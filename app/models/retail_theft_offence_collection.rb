class RetailTheftOffenceCollection < OffenceCollection
  attribute :retail_theft_offences, Array[RetailTheftOffence], relation: true
  attribute :type, String, writer: :private, default: 'RetailTheftOffences'

  def not_guilty_anticipated_plea?
    retail_theft_offences.any?(&:not_guilty_anticipated_plea?)
  end

  alias_method :offences, :retail_theft_offences
end
