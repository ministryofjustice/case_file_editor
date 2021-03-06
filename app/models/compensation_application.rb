class CompensationApplication
  include BasicModel

  attribute :defendant_names, Array[PersonName]
  validates :defendant_names,
    length: { minimum: 1 }

  attribute :reasons_for_application, Array[String]
  validates :reasons_for_application,
    array_inclusion: { in: Enumerations::CompensationReason },
    length: { minimum: 1 },
    array_uniqueness: true

  attribute :details_of_expenses, String
  validates :details_of_expenses,
    presence: true,
    if: :other_expenses?
  validates :details_of_expenses,
    absence: true,
    unless: :other_expenses?

  attribute :details_of_other_losses, String
  validates :details_of_other_losses,
    presence: true,
    if: :other_losses?
  validates :details_of_other_losses,
    absence: true,
    unless: :other_losses?

  attribute :amount_compensation_requested, Integer
  validates :amount_compensation_requested, presence: true

  attribute :is_estimate, Virtus::Attribute::Boolean
  validates :is_estimate, boolean_presence: true

  def other_expenses?
    reasons_for_application.include?('other_expenses')
  end

  def other_losses?
    reasons_for_application.include?('other_losses')
  end

  def validate_defendant_names
    available_names = victim.case_file.defendant_names
    if (defendant_names - available_names).any?
      errors.add :defendant_names, :match_defendant
    end
  end
  validate :validate_defendant_names
end
