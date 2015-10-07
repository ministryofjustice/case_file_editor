class DomesticViolence < Event
  attribute :victim_name, PersonName
  validates :victim_name, presence: true

  attribute :relationship_description, String
  validates :relationship_description, presence: true

  attribute :length_of_relationship, Integer
  validates :length_of_relationship, presence: true

  def validate_victim(available_names)
    unless available_names.include?(victim_name)
      errors.add :victim_name, :refer_to_victim
    end
  end
end
