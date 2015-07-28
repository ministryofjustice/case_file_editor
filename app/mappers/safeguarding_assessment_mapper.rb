class SafeguardingAssessmentMapper < Yaks::Mapper
  attributes \
    :assessment_completed,
    :reasons_not_completed,
    :safeguarding_level
end
