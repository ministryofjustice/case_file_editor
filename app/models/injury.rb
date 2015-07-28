class Injury
  include Virtus.model
  include ActiveModel::Validations

  attribute :names_of_defendants_causing_injuries, Array[PersonName]
  attribute :description_of_injuries, String
  attribute :images_taken, Boolean
  attribute :image_urls, Array[String]
  attribute :images_description, String
  attribute :reason_images_not_taken, String
  attribute :received_medical_treatment, Boolean
  attribute :details_of_medical_treatment, String
  attribute :injuries_visible, Boolean
end
