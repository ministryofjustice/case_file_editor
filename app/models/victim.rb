class Victim < Witness
  attribute :victim_code_requirements_met, Boolean
  attribute :has_the_victim_made_a_vps_isb, Boolean
  attribute :victim_wish_to_attend_court, String
  validates :victim_wish_to_attend_court,
    inclusion: { in: Enumerations::VictimWish }
  attribute :rep_wish, String
  validates :rep_wish,
    inclusion: { in: Enumerations::VictimWish }
  attribute :is_retraction_statement, Boolean
  attribute :compensation_applications, Array[CompensationApplication]
end
