class NgapOtherWitnessMapper < Yaks::Mapper
  attributes \
    :witness_id,
    :type,
    :witness_type,
    :nature_of_involvement,
    :evidence_they_can_give,
    :special_measures,
    :interpreter_required,
    :interpreter_language_or_dialect,
    :wish_to_use_video_link,
    :number,
    :rank
  has_one :name
end
