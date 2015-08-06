class CommonLawNotForDisclosure < CommonLaw
  attribute :details_of_relevant_unused_material, String
  validates :details_of_relevant_unused_material, presence: true
end
