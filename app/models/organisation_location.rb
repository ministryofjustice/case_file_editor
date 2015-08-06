class OrganisationLocation
  include Virtus.model
  include ActiveModel::Validations

  attribute :ou_top_level_name, String
  validates :ou_top_level_name, presence: true

  attribute :ou_second_level_name, String
  validates :ou_second_level_name, presence: true

  attribute :ou_third_level_name, String

  attribute :ou_bottom_level_name, String
end
