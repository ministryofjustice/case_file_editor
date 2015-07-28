class WitnessMapper < Yaks::Mapper
  attributes \
    :witness_id,
    :type,
    :nature_of_involvement,
    :evidence_they_can_give,
    :special_measures,
    :interpretor_required,
    :interpretor_language_or_dialect,
    :wish_to_use_video_link

  attribute :witness_type do
    object.witness_type.value
  end
end
