class ArrayFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.all? { |v| options.fetch(:with).match(v) }
      record.errors.add attribute, :array_invalid, options
    end
  end
end
