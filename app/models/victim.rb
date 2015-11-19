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
    inclusion: { in: Enumerations::VictimWish },
    allow_nil: true

  attribute :is_retraction_statement, Virtus::Attribute::Boolean

  attribute :compensation_applications, Array[CompensationApplication],
    relation: true

  def validate_domestic_violence_specific(is_dv)
    if is_dv
      BooleanPresenceValidator.new(attributes: [:is_retraction_statement]).
        validate(self)
    end
  end
end
