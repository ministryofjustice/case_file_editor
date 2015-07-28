class InjuryMapper < Yaks::Mapper
  attributes \
    :names_of_defendants_causing_injuries,
    :description_of_injuries,
    :images_taken,
    :image_urls,
    :images_description,
    :reason_images_not_taken,
    :received_medical_treatment,
    :details_of_medical_treatment,
    :injuries_visible
end
