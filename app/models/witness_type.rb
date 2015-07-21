class WitnessType
  VALUES = %w[
    expert
    eye
    identity
    arresting officer
    interviewing officer
    child
    corroborative
    continuity
    interpreter
    police
    professional
    special
    prisoner
    vulnerable
    intimidated
    other
  ]

  attribute :value, String
  validates :value, inclusion: { in: VALUES }
end
