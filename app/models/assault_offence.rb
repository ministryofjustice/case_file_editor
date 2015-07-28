class AssaultOffence
  include Virtus.model
  include ActiveModel::Validations

  attribute :type, String, writer: :private, default: 'AssaultOffence'
  attribute :cjs_offence_code, String
  validates :cjs_offence_code, inclusion: { in: Enumerations::AssaultCjsCode }
  attribute :assault_interview_extension, AssaultInterviewExtension
  attribute :victim_name, PersonName
end
