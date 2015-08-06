class Injury
  include Virtus.model
  include ActiveModel::Validations

  attribute :names_of_defendants_causing_injuries, Array[PersonName]
  validates :names_of_defendants_causing_injuries,
    length: { minimum: 1 }

  attribute :description_of_injuries, String
  validates :description_of_injuries, presence: true

  attribute :images_taken, Boolean
  validates :images_taken, inclusion: { in: [true, false] }

  attribute :image_urls, Array[String]

  attribute :image_description, String
  validates :image_description,
    presence: true,
    if: :images_taken

  attribute :reason_images_not_taken, String
  validates :reason_images_not_taken,
    presence: true,
    unless: :images_provided?

  attribute :received_medical_treatment, Boolean
  validates :received_medical_treatment, inclusion: { in: [true, false] }

  attribute :details_of_medical_treatment, String
  validates :details_of_medical_treatment,
    presence: true,
    if: :received_medical_treatment

  attribute :injuries_visible, Boolean
  validates :injuries_visible, inclusion: { in: [true, false] }

  def images_provided?
    image_description.present? || image_urls.any?
  end
end
