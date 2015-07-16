module Person
  extend ActiveSupport::Concern

  included do
    attribute :name, Array[PersonName]
    attribute :date_of_birth, Date
  end
end
