class InitiationType
  VALUES = %w[
    charge_sheet
    postal_requisition
    summons
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
