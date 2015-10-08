class RetailTheftInterviewExtension
  include BasicModel

  attribute :admit_taking_property, String
  validates :admit_taking_property,
    inclusion: { in: Enumerations::Admission }

  attribute :admit_being_dishonest, Virtus::Attribute::Boolean
  validates :admit_being_dishonest,
    boolean_presence: true

  attribute :admit_intending_to_permanently_deprive, Virtus::Attribute::Boolean
  validates :admit_intending_to_permanently_deprive,
    boolean_presence: true
end
