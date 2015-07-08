class PersonName < Name
  attribute :surname, String
  attribute :given_name, Array[String]

  # TODO: validate 1+ unique given_name
end
