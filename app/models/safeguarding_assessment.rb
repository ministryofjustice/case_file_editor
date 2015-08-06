class SafeguardingAssessment
  include Virtus.model
  include ActiveModel::Validations

  attribute :assessment_completed, Boolean
  validates :assessment_completed, inclusion: { in: [true, false] }

  attribute :reasons_not_completed, String
  validates :reasons_not_completed,
    presence: true,
    unless: :assessment_completed
  validates :reasons_not_completed,
    absence: true,
    if: :assessment_completed

  attribute :safeguarding_level, String
  validates :safeguarding_level,
    inclusion: { in: Enumerations::SafeguardingLevel },
    presence: true,
    if: :assessment_completed
  validates :safeguarding_level,
    absence: true,
    unless: :assessment_completed
end
