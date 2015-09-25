class BooleanPresenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless [true, false].include?(value)
      record.errors.add(attribute, :blank, options)
    end
  end
end
