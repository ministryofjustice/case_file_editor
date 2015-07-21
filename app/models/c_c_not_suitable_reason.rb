class CCNotSuitableReason
  VALUES = %w[
    offence_not_one_for_which_conditional_caution_can_be_offered
    offence_not_admitted
    partial_defence_raised
    offence_whilst_on_bail
    liable_for_resentence_of_an_earlier_offence
    liable_for_prison_recall
    defendants_response_on arrest_co operation
    reoffending_risk_offending history
    reoffending_risk_response_to_sentence_bail
    reoffending_risk_not_reduced_by_conditions
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
