class BreachOfBail
  include Virtus.model
  include ActiveModel::Validations

  attribute :breach_details, String
  attribute :witness_statement_establishes_breach, Boolean
  attribute :key_evidence, String
  attribute :existing_bail_breached, ExistingBail
  attribute :interview, StandardInterview
end
