class RetailTheftOffence < Offence
  attribute :type, String, default: 'RetailTheftOffence'
  attribute :cjs_offence_code, String
  attribute :property_ids, Array[Number]
  attribute :interview_extension, RetailTheftInterviewExtension
end
