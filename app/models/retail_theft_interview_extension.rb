class RetailTheftInterviewExtension
  include Virtus.model
  include ActiveModel::Validations

  attribute :admit_taking_property, Boolean
  attribute :admit_being_dishonest, Boolean
  attribute :admit_intending_to_permanently_deprive, Boolean
end
