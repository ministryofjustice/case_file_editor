module CaseTypeSpecific
  def breach_of_bail_case?
    case_file.is_a?(BreachOfBailCaseFile)
  end

  def first_hearing_case?
    case_file.is_a?(FirstHearingCaseFile)
  end
end
