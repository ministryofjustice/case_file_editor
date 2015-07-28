class Property
  include Virtus.model
  include ActiveModel::Validations

  attribute :property_id, Integer
  attribute :property_action, String
  validates :property_action, inclusion: { in: Enumerations::PropertyAction }
  attribute :description, String
  attribute :value, Integer
  attribute :damage_description, String
  attribute :damage_cost, String
  attribute :recovered_from, String
end
