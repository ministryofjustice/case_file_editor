class BailCondition
  include Virtus.model
  include ActiveModel::Validations

  attribute :grounds, Array[String]
  validates :grounds,
    array_inclusion: { in: Enumerations::BailConditionGround }
  attribute :condition, String
  attribute :reason, String
end
