class RetailTheftOffence < Offence
  attribute :type, String, writer: :private, default: 'RetailTheftOffence'

  attribute :cjs_offence_code, String
  validates :cjs_offence_code, inclusion: { in: Enumerations::RetailCjsCode }

  attribute :property_ids, Array[Integer]
  validates :property_ids, length: { minimum: 1 }

  attribute :retail_theft_interview_extension, RetailTheftInterviewExtension
  validates :retail_theft_interview_extension, presence: true

  def validate_property_ids(available_ids)
    unless property_ids.all? { |id| available_ids.include?(id) }
      errors.add :property_ids, :refer_to_property
    end
  end
end
