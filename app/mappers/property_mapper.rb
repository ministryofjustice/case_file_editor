class PropertyMapper < Yaks::Mapper
  attributes \
    :property_id,
    :property_action,
    :description,
    :value,
    :damage_description,
    :damage_cost,
    :recovered_from
end
