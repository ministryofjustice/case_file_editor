class Victim < Witness
  include Virtus.relations(as: :victim)

  validates :witness_type,
    array_inclusion: { in: Enumerations::VictimWitnessType }

  attribute :victim_code_requirements_met, Virtus::Attribute::Boolean
  validates :victim_code_requirements_met, boolean_presence: true

  attribute :has_the_victim_made_a_vps_isb, Virtus::Attribute::Boolean
  validates :has_the_victim_made_a_vps_isb, boolean_presence: true

  attribute :victim_wish_to_attend_court, String
  validates :victim_wish_to_attend_court,
    inclusion: { in: Enumerations::VictimWish },
    allow_nil: true

  attribute :rep_wish, String
  validates :rep_wish,
    inclusion: { in: Enumerations::RepWish },
    allow_nil: true

  attribute :is_retraction_statement, Virtus::Attribute::Boolean
  validates :is_retraction_statement,
    boolean_presence: true,
    if: :domestic_violence_case?

  attribute :compensation_applications, Array[CompensationApplication],
    relation: true

  delegate :domestic_violence_case?, to: :case_file
end
