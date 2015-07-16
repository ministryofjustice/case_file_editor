class RemandApplication
  include Virtus.model

  attribute :substantial_grounds, Array[BailOpposition]
  attribute :bail_conditions, Array[BailCondition]
end
