class SafeguardingAssessment
  include BasicModel

  attribute :assessment_completed, Virtus::Attribute::Boolean
  validates :assessment_completed, boolean_presence: true

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
    if: :assessment_completed
  validates :safeguarding_level,
    absence: true,
    unless: :assessment_completed
end
