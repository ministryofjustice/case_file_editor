class BreachOfBailCaseFile < CaseFile
  attribute :type, String, writer: :private, default: 'BobDCF'

  validates :case_markers, length: { is: 0 }
  validates :defendants, length: { is: 1 }
  validates :common_law_disclosure, absence: true
  validates :likely_case_progression, absence: true
  validates :multimedia_evidence, array_uniqueness: true
  validates :is_hearsay, boolean_absence: true
  validates :hearsay_details, absence: true
  validates :expert_evidence, boolean_absence: true
  validates :test_code, absence: true
  validates :pca_cps, boolean_absence: true
  validates :property, length: { is: 0 }
end
