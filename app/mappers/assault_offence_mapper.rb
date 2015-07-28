class AssaultOffenceMapper < Yaks::Mapper
  attributes \
    :type,
    :assault_interview_extension,
    :victim_name

  attribute :cjs_offence_code do
    object.cjs_offence_code.value
  end
end
