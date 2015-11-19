module PropertyIdValidation
  extend ActiveSupport::Concern

  included do
    def validate_property_ids
      return unless respond_to?(:property_ids)
      available_ids = offence_collection.defendant.case_file.property_ids
      unless property_ids.all? { |id| available_ids.include?(id) }
        errors.add :property_ids, :refer_to_property
      end
    end
    validate :validate_property_ids
  end
end
