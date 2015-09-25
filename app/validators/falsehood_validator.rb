class FalsehoodValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value == false
      record.errors.add(attribute, :falsehood, options)
    end
  end
end
