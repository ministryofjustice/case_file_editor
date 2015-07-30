class RetailTheftOffence < Offence
  attribute :type, String, writer: :private, default: 'RetailTheftOffence'
  attribute :cjs_offence_code, String
  validates :cjs_offence_code, inclusion: { in: Enumerations::RetailCjsCode }
  attribute :property_ids, Array[Integer]
  attribute :retail_theft_interview_extension, RetailTheftInterviewExtension
end
