module Person
  include Virtus.module

  attribute :name, Array[PersonName]
  attribute :date_of_birth, Date
end
