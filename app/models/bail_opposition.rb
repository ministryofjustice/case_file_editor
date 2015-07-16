class BailOpposition
  include Virtus.model

  attribute :opposition_ground, BailOppositionGround
  attribute :justification, String
end
