class CaseFile
  include BasicModel
  include Virtus.relations(as: :case_file)

  attribute :schema_version, String
  validates :schema_version, presence: true

  attribute :case, Case
  validates :case,
    presence: true	

  end
