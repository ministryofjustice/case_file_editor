class AssaultOffence
  include Virtus.model

  attribute :type, String, writer: :private, default: 'AssaultOffence'
  attribute :cjs_offence_code, AssaultCjsCode
  attribute :assault_interview_extension, RetailTheftInterviewExtension
  attribute :victim_name, PersonName
end
