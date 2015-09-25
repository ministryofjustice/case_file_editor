module AgeCalculation
  def age(at_date)
    date_of_birth && AgeCalculator.new.age(date_of_birth, at_date)
  end
end
