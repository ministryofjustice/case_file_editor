class SafeguardingLevel
  VALUES = %w[
    moderate
    moderate_serious
    serious
    severe
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
