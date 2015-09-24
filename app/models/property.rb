class Property
  include Virtus.model
  include ActiveModel::Validations

  attribute :property_id, Integer
  validates :property_id, presence: true
  # TODO: validate uniqueness within case file

  attribute :property_action, String
  validates :property_action, inclusion: { in: Enumerations::PropertyAction }

  attribute :description, String
  validates :description, presence: true

  attribute :value, Float # Not ideal, but it's floating-point in the JSON too
  validates :value, presence: true

  attribute :damage_description, String
  validates :damage_description,
    presence: {
      message: 'must be present if item was damaged'
    },
    if: :damaged?
  validates :damage_description,
    absence: {
      message: 'must be absent unless item was damaged'
    },
    unless: :damaged?

  attribute :damage_cost, String
  validates :damage_cost,
    presence: {
      message: 'must be present if item was damaged'
    },
    if: :damaged?
  validates :damage_cost,
    absence: {
      message: 'must be absent unless item was damaged'
    },
    unless: :damaged?

  attribute :recovered_from, String
  validates :recovered_from,
    presence: {
      message: 'must be present if item was recovered'
    },
    if: :recovered?
  validates :recovered_from,
    absence: {
      message: 'must be absent unless item was recovered'
    },
    unless: :recovered?

  def damaged?
    %w[ stolen_recovered_damaged damaged ].include?(property_action)
  end

  def recovered?
    %w[ stolen_recovered_damaged stolen_recovered ].include?(property_action)
  end
end
