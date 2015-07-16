class Event
  extend AbstractClass
  include Virtus.model

  attribute :date, Date
  attribute :type, String
end
