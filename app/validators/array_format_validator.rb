class ArrayFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.all? { |v| options[:with].match(v) }
      record.errors[attribute] << (options[:message] || 'invalid value')
    end
  end
end
