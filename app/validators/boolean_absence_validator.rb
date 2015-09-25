class BooleanAbsenceValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.nil?
      record.errors.add(attribute, :present, options)
    end
  end
end
