class GenericOffence < Offence
  include PropertyIdValidation

  attribute :type, String, writer: :private, default: 'GenericOffence'

  attribute :cjs_offence_code, String
  validates :cjs_offence_code, presence: true
  # TODO: validate against CJSE Data Standards v5.0 sec. 3.11?

  attribute :property_ids, Array[Integer]

  attribute :victim_names, Array[Name]
end
