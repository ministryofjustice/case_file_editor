class ArrayUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.uniq.length == value.length
      record.errors.add attribute, :array_unique, options
    end
  end
end
