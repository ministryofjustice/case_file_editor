class BailCondition
  include Virtus.model
  include ActiveModel::Validations

  attribute :grounds, Array[String]
  validates :grounds,
    array_inclusion: { in: Enumerations::BailConditionGround },
    length: { minimum: 1 }

  attribute :condition, String
  validates :condition, presence: true

  attribute :reason, String
  validates :reason, presence: true
end
