class ExistingBailMapper < Yaks::Mapper
  attributes \
    :original_charge_wording,
    :bailed_from,
    :bailed_date,
    :to_appear_at,
    :datetime_to_appear
  has_many :list_of_conditions
end
