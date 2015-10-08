class AssaultInterviewExtension
  include BasicModel

  attribute :admits_involvement_in_incident, Virtus::Attribute::Boolean
  validates :admits_involvement_in_incident,
    boolean_presence: true

  attribute :admits_assaulting_victim, Virtus::Attribute::Boolean
  validates :admits_assaulting_victim,
    boolean_presence: true

  attribute :admits_causing_the_injuries, String
  validates :admits_causing_the_injuries,
    inclusion: { in: Enumerations::Admission }

  attribute :accepts_victims_version_of_events, Virtus::Attribute::Boolean
  validates :accepts_victims_version_of_events,
    boolean_presence: true

  attribute :position_of_trust, Virtus::Attribute::Boolean
  validates :position_of_trust,
    boolean_presence: true

  attribute :self_defence_put_forward, Virtus::Attribute::Boolean
  validates :self_defence_put_forward,
    boolean_presence: true
end
