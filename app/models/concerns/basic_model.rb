module BasicModel
  extend ActiveSupport::Concern

  included do
    include Virtus.model
    include ActiveModel::Validations

    # Copied from activemodel/lib/active_model/validations.rb with error clearing
    # removed (because we are setting errors in parent objects as well).
    #
    def validate(context = nil)
      current_context, self.validation_context = validation_context, context
      run_validations!
    ensure
      self.validation_context = current_context
    end
  end
end
