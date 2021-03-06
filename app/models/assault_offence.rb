class AssaultOffence < Offence
  attribute :type, String, writer: :private, default: 'AssaultOffence'

  attribute :cjs_offence_code, String
  validates :cjs_offence_code, inclusion: { in: Enumerations::AssaultCjsCode }

  attribute :assault_interview_extension, AssaultInterviewExtension

  attribute :victim_name, PersonName
  validates :victim_name, presence: true
end
