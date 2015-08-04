class MmeExporter < GenericExporter
  attributes \
    :date,
    :type,
    :id,
    :end_date,
    :evidential_value,
    :relied_upon_trial,
    :relied_upon_sentence,
    :description_of_what_is_contained_in_multimedia_evidence,
    :total_duration,
    :url
end
