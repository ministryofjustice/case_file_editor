class Victim < Witness
  attribute :victim_code_requirements_met, Boolean
  attribute :has_the_victim_made_a_vps_isb, Boolean
  attribute :victim_wish_to_attend_court, VictimWish
  attribute :rep_wish, VictimWish
  attribute :is_retraction_statement, Boolean
  attribute :compensation_applications, Array[CompensationApplication]
end
