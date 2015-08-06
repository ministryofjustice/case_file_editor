class NotInterviewed < Interview
  attribute :reason, String
  validates :reason, presence: true
end
