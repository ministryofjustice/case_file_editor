class Offence < Event
  extend AbstractClass

  attribute :type, String, writer: :private, default: 'Offence'
  attribute :from_date, Date
  attribute :to_date, Date
  attribute :offence_title, String
  attribute :charge_wording,  String
  attribute :reply_to_charge, String
  attribute :points_to_prove_met_by, String
  attribute :demeanour_at_incident, String
  attribute :anticipated_plea, Integer
  attribute :committed_on_bail, Boolean
  attribute :children_present, Boolean
  attribute :ages_of_children, Array[String]
end
