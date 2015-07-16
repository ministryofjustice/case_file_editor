class BailCondition
  include Virtus.model

  attribute :grounds, Array[BailConditionGround]
  attribute :condition, String
  attribute :reason, String
end
