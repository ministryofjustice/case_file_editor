class BailOpposition
  include BasicModel

  attribute :opposition_ground, String
  validates :opposition_ground,
    inclusion: { in: Enumerations::BailOppositionGround }

  attribute :justification, String
  validates :justification, presence: true
end
