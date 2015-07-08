class Person
  include Virtus.model

  attribute :name, Array[PersonName]
  attribute :date_of_birth, Date
end
