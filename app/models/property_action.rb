class PropertyAction < Enumeration
  self.values = %w[
    stolen_not_recovered
    stolen_recovered
    stolen_recovered_damaged
    damaged
  ]
end
