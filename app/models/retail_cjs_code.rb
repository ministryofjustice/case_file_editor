class RetailCjsCode
  VALUES = %w[
    h410
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
