module Person
  include Virtus.module
  include AgeCalculation

  attribute :name, Array[PersonName]
  attribute :date_of_birth, Date
end
