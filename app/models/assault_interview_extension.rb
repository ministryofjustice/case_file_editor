class AssaultInterviewExtension
  include Virtus.model
  include ActiveModel::Validations

  attribute :admits_involvement_in_incident, Boolean
  validates :admits_involvement_in_incident,
    inclusion: { in: [true, false] }

  attribute :admits_assaulting_victim, Boolean
  validates :admits_assaulting_victim,
    inclusion: { in: [true, false] }

  attribute :admits_causing_the_injuries, String
  validates :admits_causing_the_injuries,
    inclusion: { in: Enumerations::Admission }

  attribute :accepts_victims_version_of_events, Boolean
  validates :accepts_victims_version_of_events,
    inclusion: { in: [true, false] }

  attribute :position_of_trust, Boolean
  validates :position_of_trust,
    inclusion: { in: [true, false] }

  attribute :self_defence_put_forward, Boolean
  validates :self_defence_put_forward,
    inclusion: { in: [true, false] }
end
