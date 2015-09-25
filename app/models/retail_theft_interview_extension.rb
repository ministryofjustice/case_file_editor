class RetailTheftInterviewExtension
  include Virtus.model
  include ActiveModel::Validations

  attribute :admit_taking_property, String
  validates :admit_taking_property,
    inclusion: { in: Enumerations::Admission }

  attribute :admit_being_dishonest, Virtus::Attribute::Boolean
  validates :admit_being_dishonest,
    inclusion: { in: [true, false] }

  attribute :admit_intending_to_permanently_deprive, Virtus::Attribute::Boolean
  validates :admit_intending_to_permanently_deprive,
    inclusion: { in: [true, false] }
end
