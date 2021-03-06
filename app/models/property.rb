class Property
  include BasicModel
  include DuplicateIdentifiers

  attribute :property_id, Integer
  validates :property_id, presence: true

  attribute :property_action, String
  validates :property_action, inclusion: { in: Enumerations::PropertyAction }

  attribute :description, String
  validates :description, presence: true

  attribute :value, Float # Not ideal, but it's floating-point in the JSON too

  attribute :damage_description, String
  validates :damage_description,
    presence: true,
    if: :damaged?
  validates :damage_description,
    absence: true,
    unless: :damaged?

  attribute :damage_cost, String
  validates :damage_cost,
    presence: true,
    if: :damaged?
  validates :damage_cost,
    absence: true,
    unless: :damaged?

  attribute :recovered_from, String
  validates :recovered_from,
    presence: true,
    if: :recovered?
  validates :recovered_from,
    absence: true,
    unless: :recovered?

  def damaged?
    %w[ stolen_recovered_damaged damaged ].include?(property_action)
  end

  def recovered?
    %w[ stolen_recovered_damaged stolen_recovered ].include?(property_action)
  end

  def validate_id_uniqueness
    if duplicate_identifiers(case_file.property_ids).include?(property_id)
      errors.add :property_id, :unique_within_case_file
    end
  end
  validate :validate_id_uniqueness
end
