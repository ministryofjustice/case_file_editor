class ArrayInclusionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.all? { |g| options.fetch(:in).include?(g) }
      record.errors.add attribute, :array_inclusion, options
    end
  end
end
