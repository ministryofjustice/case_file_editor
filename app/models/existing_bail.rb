class ExistingBail
  include Virtus.model
  include ActiveModel::Validations

  attribute :original_charge_wording, Array[String]
  attribute :bailed_from, OrganisationLocation
  attribute :bailed_date, Date
  attribute :to_appear_at, OrganisationLocation
  attribute :datetime_to_appear, DateTime
  attribute :list_of_conditions, Array[BailCondition]
end
