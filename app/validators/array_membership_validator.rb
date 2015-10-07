class ArrayMembershipValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.any? { |g| options.fetch(:of) == g }
      record.errors.add attribute, :array_membership, options
    end
  end
end
