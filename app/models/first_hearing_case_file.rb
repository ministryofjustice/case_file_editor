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

  validates :is_hearsay,
    boolean_presence: true,
    if: :not_guilty_anticipated_plea?
  validates :is_hearsay,
    boolean_absence: true,
    unless: :not_guilty_anticipated_plea?

  validates :hearsay_details,
    presence: true,
    if: :is_hearsay
  validates :hearsay_details,
    absence: true,
    unless: :is_hearsay

  validates :expert_evidence, boolean_presence: true

  validates :test_code,
    inclusion: { in: Enumerations::TestCode }

  validates :pca_cps, boolean_presence: true

  validates :property, array_uniqueness: true
end
