class CommonLawNotForDisclosure < CommonLaw
  attribute :type, String,
    writer: :private, default: 'CommonLawNotForDisclosure'

  attribute :details_of_relevant_unused_material, String
  validates :details_of_relevant_unused_material, presence: true
end
