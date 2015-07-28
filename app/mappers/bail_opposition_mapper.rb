class BailOppositionMapper < Yaks::Mapper
  attributes \
    :justification

  attribute :opposition_ground do
    object.opposition_ground.value
  end
end
