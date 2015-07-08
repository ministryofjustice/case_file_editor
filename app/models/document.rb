class Document
  include Virtus.model

  attribute :category, String
  attribute :type, String
  attribute :authority, String
end
