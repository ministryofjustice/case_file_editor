class Event
  include BasicModel
  extend AbstractClass

  attribute :date, Date
  attribute :type, String
end
