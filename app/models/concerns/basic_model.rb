module BasicModel
  extend ActiveSupport::Concern

  included do
    include Virtus.model
    include ActiveModel::Validations
  end
end
