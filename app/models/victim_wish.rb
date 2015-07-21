class VictimWish
  VALUES = %w[
    yes_cps_to_read
    yes_victim_to_read
    no_cps_to_read
    no_cps_to_disclose_and_not_to_read
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
