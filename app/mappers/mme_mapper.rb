class MmeMapper < Yaks::Mapper
  attributes \
    :date,
    :id,
    :end_date,
    :evidential_value,
    :relied_upon_trial,
    :relied_upon_sentence,
    :description_of_what_is_seen_in_multimedia_evidence,
    :total_duration,
    :url

  attribute :type do
    object.type.value
  end
end
