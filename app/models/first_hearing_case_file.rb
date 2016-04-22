class FirstHearingCaseFile < Case
  attribute :type, String, writer: :private, default: 'FirstHearingDCF'

  validates :case_markers,
    array_inclusion: { in: Enumerations::CaseMarker }
  validates :case_markers,
    array_membership: { of: 'YoungWitnessInitiative' },
    if: :young_witness?
  validates :case_markers,
    array_membership: { of: 'CrimeAgainstAnOlderPerson' },
    if: :older_victim?

  validates :defendants,
    length: { minimum: 1 },
    array_uniqueness: true

  validates :likely_case_progression,
    inclusion: { in: Enumerations::LikelyCaseProgression, allow_nil: true }
  validates :likely_case_progression, presence: true

  validates :multimedia_evidence, array_uniqueness: true

  validates :expert_evidence, boolean_presence: true

  validates :test_code,
    inclusion: { in: Enumerations::TestCode }

  validates :pca_cps, boolean_presence: true

  validates :property, array_uniqueness: true
end
