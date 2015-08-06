class PersonName < Name
  attribute :surname, String
  validates :surname, presence: true

  attribute :given_name, Array[String]
  validates :given_name, length: { minimum: 1 }
end
