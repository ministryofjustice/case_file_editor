class DomesticViolence < Event
  attribute :victim_name, PersonName
  attribute :relationship_description, String
  attribute :length_of_relationship, Integer
end
