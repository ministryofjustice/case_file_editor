class TruthValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value == true
      record.errors.add(attribute, :truth, options)
    end
  end
end
