require 'forwardable'

class PersonName < Name
  extend Forwardable

  attribute :surname, String
  validates :surname, presence: true

  attribute :given_name, Array[String]
  validates :given_name, length: { minimum: 1 }

  def full_name
    (given_name + [surname]).compact.join(' ')
  end

  def_delegators :full_name, :hash

  def eql?(other)
    surname == other.surname && given_name == other.given_name
  end

  alias_method :==, :eql?
end
