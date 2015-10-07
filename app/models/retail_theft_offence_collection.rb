class RetailTheftOffenceCollection < OffenceCollection
  attribute :retail_theft_offences, Array[RetailTheftOffence]
  attribute :type, String, writer: :private, default: 'RetailTheftOffences'

  def anticipated_guilty_plea?
    retail_theft_offences.any?(&:anticipated_guilty_plea?)
  end

  alias_method :offences, :retail_theft_offences

  def validate_property_ids(available_ids)
    retail_theft_offences.each do |offence|
      offence.validate_property_ids available_ids
    end
  end
end
