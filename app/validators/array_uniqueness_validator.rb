class ArrayUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.uniq.length == value.length
      record.errors[attribute] << (options[:message] || 'invalid value')
    end
  end
end
