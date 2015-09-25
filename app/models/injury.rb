class Injury
  include Virtus.model
  include ActiveModel::Validations

  attribute :names_of_defendants_causing_injuries, Array[PersonName]
  validates :names_of_defendants_causing_injuries,
    length: { minimum: 1 }

  attribute :description_of_injuries, String
  validates :description_of_injuries, presence: true

  attribute :images_taken, Virtus::Attribute::Boolean
  validates :images_taken, inclusion: { in: [true, false] }

  attribute :image_urls, Array[String]

  attribute :image_description, String
  validates :image_description,
    presence: {
      message: 'must be present if images were taken'
    },
    if: :images_taken

  attribute :reason_images_not_taken, String
  validates :reason_images_not_taken,
    presence: {
      message: 'must be present if images are not provided'
    },
    unless: :images_provided?

  attribute :received_medical_treatment, Virtus::Attribute::Boolean
  validates :received_medical_treatment, inclusion: { in: [true, false] }

  attribute :details_of_medical_treatment, String
  validates :details_of_medical_treatment,
    presence: {
      message: 'must be present if medical treatment was received'
    },
    if: :received_medical_treatment

  attribute :injuries_visible, Virtus::Attribute::Boolean
  validates :injuries_visible, inclusion: { in: [true, false] }

  def images_provided?
    image_description.present? || image_urls.any?
  end
end
