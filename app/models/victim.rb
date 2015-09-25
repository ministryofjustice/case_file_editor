class Victim < Witness
  validates :witness_type,
    array_inclusion: { in: Enumerations::VictimWitnessType }

  attribute :victim_code_requirements_met, Virtus::Attribute::Boolean
  validates :victim_code_requirements_met, inclusion: { in: [true, false] }

  attribute :has_the_victim_made_a_vps_isb, Virtus::Attribute::Boolean
  validates :has_the_victim_made_a_vps_isb, inclusion: { in: [true, false] }

  attribute :victim_wish_to_attend_court, String
  validates :victim_wish_to_attend_court,
    inclusion: { in: Enumerations::VictimWish },
    allow_nil: true

  attribute :rep_wish, String
  validates :rep_wish,
    inclusion: { in: Enumerations::VictimWish },
    allow_nil: true

  attribute :is_retraction_statement, Virtus::Attribute::Boolean
  # TODO: validate if case is DV

  attribute :compensation_applications, Array[CompensationApplication]
end
