class RemandApplication
  include Virtus.model
  include ActiveModel::Validations

  attribute :substantial_grounds, Array[BailOpposition]
  attribute :bail_conditions, Array[BailCondition]
end
