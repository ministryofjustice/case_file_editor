class AssaultInterviewExtension
  include Virtus.model
  include ActiveModel::Validations

  attribute :admits_involvement_in_incident, Boolean
  attribute :admits_assaulting_victim, Boolean
  attribute :admits_causing_the_injuries, Boolean
  attribute :accepts_victims_version_of_events, Boolean
  attribute :position_of_trust, Boolean
  attribute :self_defence_put_forward, Boolean
end
