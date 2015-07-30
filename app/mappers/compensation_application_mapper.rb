class CompensationApplicationMapper < Yaks::Mapper
  attributes \
    :reason_for_application,
    :details_of_expenses,
    :details_of_other_losses,
    :amount_compensation_requested,
    :is_estimate
  has_many :defendant_names
end
