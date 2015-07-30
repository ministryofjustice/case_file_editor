class StandardInterviewMapper < Yaks::Mapper
  attributes \
    :date,
    :type,
    :defendant_legally_represented,
    :legal_representative_firm,
    :special_warnings_given,
    :no_comment_response,
    :questions_asked,
    :admissions_made,
    :denials,
    :defences,
    :explanations,
    :mitigations,
    :aggravating_features
  has_one :legally_represented_by
  has_many :interpreters
  has_one :appropriate_adults
end
