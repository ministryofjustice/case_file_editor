class DomesticViolence < Event
  attribute :victim_name, PersonName
  validates :victim_name, presence: true
  # TODO: validate against listed victims

  attribute :relationship_description, String
  validates :relationship_description, presence: true

  attribute :length_of_relationship, Integer
  validates :length_of_relationship, presence: true
end
