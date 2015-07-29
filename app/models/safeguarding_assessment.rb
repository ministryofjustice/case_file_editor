class SafeguardingAssessment
  include Virtus.model
  include ActiveModel::Validations

  attribute :assessment_completed, Boolean
  attribute :reasons_not_completed, String
  attribute :safeguarding_level, String
  validates :safeguarding_level,
    inclusion: { in: Enumerations::SafeguardingLevel }
end
