class StandardInterviewExporter < GenericExporter
  attributes \
    :date,
    :type,
    :defendant_legally_represented,
    :legally_represented_by,
    :legal_representative_firm,
    :interpreters,
    :special_warnings_given,
    :no_comment_response,
    :questions_asked,
    :admissions_made,
    :denials,
    :defences,
    :explanations,
    :mitigations,
    :aggravating_features,
    :appropriate_adults
end
