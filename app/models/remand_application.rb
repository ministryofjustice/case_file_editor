class RemandApplication
  include BasicModel

  attribute :substantial_grounds, Array[BailOpposition]
  validates :substantial_grounds, length: { minimum: 1 }

  attribute :bail_conditions, Array[BailCondition]
  validates :bail_conditions, array_uniqueness: true
end
