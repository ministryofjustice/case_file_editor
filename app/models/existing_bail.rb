class ExistingBail
  include Virtus.model
  include ActiveModel::Validations

  attribute :original_charge_wording, Array[String]
  validates :original_charge_wording, length: { minimum: 1 }

  attribute :bailed_from, OrganisationLocation
  validates :bailed_from, presence: true

  attribute :bailed_date, Date
  validates :bailed_date, presence: true

  attribute :to_appear_at, OrganisationLocation
  validates :to_appear_at, presence: true

  attribute :datetime_to_appear, DateTime
  validates :datetime_to_appear, presence: true

  attribute :list_of_conditions, Array[BailCondition]
  # TODO: Validate unclear requirement:
  # "One condition to be provided per String."
end
