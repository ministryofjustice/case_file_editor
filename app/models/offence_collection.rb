class OffenceCollection
  include BasicModel
  extend AbstractClass
  include Virtus.relations(as: :offence_collection)

  delegate :domestic_violence_case?, to: :defendant
end
