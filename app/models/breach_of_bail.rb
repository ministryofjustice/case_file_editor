class BreachOfBail
  include Virtus.model
  include ActiveModel::Validations

  attribute :breach_details, String
  validates :breach_details, presence: true

  attribute :witness_statement_establishes_breach, Boolean
  validates :witness_statement_establishes_breach,
    inclusion: { in: [true, false] }

  attribute :key_evidence, String
  validates :key_evidence, presence: true

  attribute :existing_bail_breached, ExistingBail
  validates :existing_bail_breached, presence: true

  attribute :interview, StandardInterview
end
