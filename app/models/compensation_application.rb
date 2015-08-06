class CompensationApplication
  include Virtus.model
  include ActiveModel::Validations

  attribute :defendant_names, Array[PersonName]
  validates :defendant_names,
    length: { minimum: 1 }
  # TODO: validate against defendants

  attribute :reasons_for_application, Array[String]
  validates :reasons_for_application,
    array_inclusion: { in: Enumerations::CompensationReason },
    length: { minimum: 1 },
    array_uniqueness: true

  attribute :details_of_expenses, String
  validates :details_of_expenses,
    inclusion: { in: [true, false] },
    if: :other_expenses?
  validates :details_of_expenses,
    inclusion: { in: [nil] },
    unless: :other_expenses?

  attribute :details_of_other_losses, String
  validates :details_of_other_losses,
    inclusion: { in: [true, false] },
    if: :other_losses?
  validates :details_of_other_losses,
    inclusion: { in: [nil] },
    unless: :other_losses?

  attribute :amount_compensation_requested, Integer
  validates :amount_compensation_requested, presence: true

  attribute :is_estimate, Boolean
  validates :is_estimate, inclusion: { in: [true, false] }

  def other_expenses?
    reasons_for_application.include?('other_expenses')
  end

  def other_losses?
    reasons_for_application.include?('other_losses')
  end
end
