class RetailTheftOffenceCollection < OffenceCollection
  attribute :retail_theft_offences, Array[RetailTheftOffence]
  attribute :type, String, writer: :private, default: 'RetailTheftOffences'
end
