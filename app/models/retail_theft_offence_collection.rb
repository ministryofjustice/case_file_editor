class RetailTheftOffenceCollection < OffenceCollection
  attribute :retail_theft_offences, Array[RetailTheftOffence]
  attribute :type, String, writer: :private, default: 'RetailTheftOffences'

  def anticipated_guilty_plea?
    retail_theft_offences.any?(&:anticipated_guilty_plea?)
  end
end
