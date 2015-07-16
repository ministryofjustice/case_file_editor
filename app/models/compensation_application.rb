class CompensationApplication
  include Virtus.model

  attribute :defendant_names, Array[PersonName]
  attribute :reason_for_application, Array[String]
  attribute :details_of_expenses, String
  attribute :details_of_other_losses, String
  attribute :amount_compensation_requested, Number
  attribute :is_estimate, Boolean
end
