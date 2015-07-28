class DomesticViolenceMapper < Yaks::Mapper
  attributes \
    :date,
    :type,
    :victim_name,
    :relationship_description,
    :length_of_relationship
end
