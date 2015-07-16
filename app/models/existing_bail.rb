class ExistingBail
  include Virtus.model

  attribute :original_charge_wording, Array[String]
  attribute :bailed_from, String
  attribute :bailed_date, Date
  attribute :to_appear_at, String
  attribute :datetime_to_appear, DateTime
  attribute :list_of_conditions, Array[BailCondition]
end
