class CaseFile
  include BasicModel

  attribute :schema_version, String
  validates :schema_version, presence: true

  attribute :case, Case
  validates :case,
    presence: true	

  end
