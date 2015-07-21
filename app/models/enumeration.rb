class Enumeration
  include Virtus.model
  include ActiveModel::Validations

  class << self
    attr_accessor :values
  end

  attribute :value, String
  validates :value, inclusion: { in: ->(obj) { obj.class.values } }
end
