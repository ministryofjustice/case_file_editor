class BailConditionMapper < Yaks::Mapper
  attributes \
    :condition,
    :reason

  attribute :grounds do
    object.grounds.value
  end
end
