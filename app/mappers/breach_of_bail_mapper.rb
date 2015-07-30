class BreachOfBailMapper < Yaks::Mapper
  attributes \
    :breach_details,
    :witness_statement_establishes_breach,
    :key_evidence
  has_one :existing_bail_breached
  has_one :interview
end
