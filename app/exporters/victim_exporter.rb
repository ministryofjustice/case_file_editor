class VictimExporter < WitnessSubclassExporter
  attributes \
    :type,
    :witness_type,
    :victim_code_requirements_met,
    :has_the_victim_made_a_vps_isb,
    :victim_wish_to_attend_court,
    :rep_wish,
    :is_retraction_statement,
    :compensation_applications
end
