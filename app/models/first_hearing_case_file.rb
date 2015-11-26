class FirstHearingCaseFile < CaseFile
  attribute :type, String, writer: :private, default: 'FirstHearingDCF'
end
