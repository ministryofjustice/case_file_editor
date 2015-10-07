class GenericOffence < Offence
  attribute :type, String, writer: :private, default: 'GenericOffence'

  attribute :cjs_offence_code, String
  validates :cjs_offence_code, presence: true
  # TODO: validate against CJSE Data Standards v5.0 sec. 3.11?

  attribute :property_ids, Array[Integer]

  attribute :victim_names, Array[PersonName]

  def validate_property_ids(available_ids)
    unless property_ids.all? { |id| available_ids.include?(id) }
      errors.add :property_ids, :refer_to_property
    end
  end
end
