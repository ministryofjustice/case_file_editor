class RetailTheftOffence < Offence
  attribute :type, String, writer: :private, default: 'RetailTheftOffence'
  attribute :cjs_offence_code, RetailCjsCode
  attribute :property_ids, Array[Integer]
  attribute :interview_extension, RetailTheftInterviewExtension
end
