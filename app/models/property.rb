class Property
  include Virtus.model

  attribute :property_id, Number
  attribute :property_action, PropertyAction
  attribute :description, String
  attribute :value, Number
  attribute :damage_description, String
  attribute :damage_cost, String
  attribute :recovered_from, String
end
