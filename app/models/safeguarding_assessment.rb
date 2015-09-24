class SafeguardingAssessment
  include Virtus.model
  include ActiveModel::Validations

  attribute :assessment_completed, Boolean
  validates :assessment_completed, inclusion: { in: [true, false] }

  attribute :reasons_not_completed, String
  validates :reasons_not_completed,
    presence: {
      message: 'must be present unless assessment completed'
    },
    unless: :assessment_completed
  validates :reasons_not_completed,
    absence: {
      message: 'must be absent if assessment completed'
    },
    if: :assessment_completed

  attribute :safeguarding_level, String
  validates :safeguarding_level,
    inclusion: {
      in: Enumerations::SafeguardingLevel,
      message: 'must be a valid safeguarding level if assessment completed'
    },
    if: :assessment_completed
  validates :safeguarding_level,
    absence: {
      message: 'must be absent unless assessment completed'
    },
    unless: :assessment_completed
end
