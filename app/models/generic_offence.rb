class GenericOffence < Offence
  attribute :type, String, writer: :private, default: 'GenericOffence'
  attribute :cjs_offence_code, String
  attribute :property_ids, Array[Integer]
  attribute :victim_names, Array[PersonName]
end
