require 'forwardable'

class OfficerName < PersonName
  attribute :rank, String
  validates :rank, presence: true

  attribute :collar_number, String
  validates :collar_number, presence: true
end
