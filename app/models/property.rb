class Property
  include Virtus.model

  attribute :property_id, Integer
  attribute :property_action, PropertyAction
  attribute :description, String
  attribute :value, Integer
  attribute :damage_description, String
  attribute :damage_cost, String
  attribute :recovered_from, String
end
