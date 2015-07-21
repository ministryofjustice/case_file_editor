class AssaultCjsCode
  VALUES = %w[
    h4302
    h901
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
