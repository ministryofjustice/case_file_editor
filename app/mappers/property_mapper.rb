class PropertyMapper < Yaks::Mapper
  attributes \
    :property_id,
    :description,
    :value,
    :damage_description,
    :damage_cost,
    :recovered_from

  attribute :property_action do
    object.property_action.value
  end
end
