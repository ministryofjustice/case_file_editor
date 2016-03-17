class RetailTheftOffence < Offence
  include PropertyIdValidation

  attribute :type, String, writer: :private, default: 'RetailTheftOffence'

  attribute :cjs_offence_code, String
  validates :cjs_offence_code, inclusion: { in: Enumerations::RetailCjsCode }

  attribute :property_ids, Array[Integer]
  validates :property_ids, length: { minimum: 1 }

  attribute :retail_theft_interview_extension, RetailTheftInterviewExtension
end
