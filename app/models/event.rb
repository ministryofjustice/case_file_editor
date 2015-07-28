class Event
  extend AbstractClass
  include Virtus.model
  include ActiveModel::Validations

  attribute :date, Date
  attribute :type, String
end
