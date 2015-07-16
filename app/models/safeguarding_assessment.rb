class SafeguardingAssessment
  include Virtus.model

  attribute :assessment_completed, Boolean
  attribute :reasons_not_completed, String
  attribute :safeguarding_level, SafeguardingLevel
end
