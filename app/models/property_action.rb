class PropertyAction
  VALUES = %w[
    stolen_not_recovered
    stolen_recovered
    stolen_recovered_damaged
    damaged
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
