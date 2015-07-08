class Event
  include Virtus.model

  attribute :date, Date
  attribute :type, String
end
