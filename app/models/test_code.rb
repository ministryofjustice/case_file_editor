class TestCode
  VALUES = %w[
    threshold_test
    full_code_test
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
