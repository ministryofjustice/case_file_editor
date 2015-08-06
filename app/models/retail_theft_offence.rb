class RetailTheftOffence < Offence
  attribute :type, String, writer: :private, default: 'RetailTheftOffence'

  attribute :cjs_offence_code, String
  validates :cjs_offence_code, inclusion: { in: Enumerations::RetailCjsCode }

  attribute :property_ids, Array[Integer]
  validates :property_ids, length: { minimum: 1 }
  # TODO: validate against property list

  attribute :retail_theft_interview_extension, RetailTheftInterviewExtension
  validates :retail_theft_interview_extension, presence: true
end
