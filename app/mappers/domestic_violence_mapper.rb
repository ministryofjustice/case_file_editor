class DomesticViolenceMapper < Yaks::Mapper
  attributes \
    :date,
    :type,
    :relationship_description,
    :length_of_relationship
  has_one :victim_name
end
