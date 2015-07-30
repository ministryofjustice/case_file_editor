class MmeRecordedResponseExporter < GenericExporter
  attributes \
    :type,
    :id,
    :defendant_shown,
    :reasons_if_not_shown,
    :defendant_comments_if_shown,
    :is_defendant_believed_to_be_in_the_mme,
    :defendant_admits_being_in_mme,
    :how_is_identification_established
end
