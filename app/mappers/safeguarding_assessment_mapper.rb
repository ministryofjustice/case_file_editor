class SafeguardingAssessmentMapper < Yaks::Mapper
  attributes \
    :assessment_completed,
    :reasons_not_completed

  attribute :safeguarding_level do
    object.safeguarding_level.value
  end
end
