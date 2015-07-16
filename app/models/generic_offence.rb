class GenericOffence < Offence
  attribute :type, String, default: 'GenericOffence'
  attribute :cjs_offence_code, String
  attribute :property_ids, Array[Number]
  attribute :victim_names, Array[PersonName]
end
