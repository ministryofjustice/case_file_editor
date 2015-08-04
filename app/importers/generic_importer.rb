class GenericImporter
  def self.importer(source)
    new(source)
  end

  def initialize(source)
    @source = source
  end

  def import
    target_class.new(params)
  end

private

  attr_reader :source

  def params
    fields.map { |f| import_field(f) }.compact.to_h
  end

  def import_field(field)
    key = field.name.to_s
    return nil unless source.key?(key)

    if field.array?
      value = source.fetch(key).map { |v| import_one(field, v) }
    else
      value = import_one(field, source.fetch(key))
    end

    [field.name, value]
  end

  def import_one(field, value)
    if field.basic?
      value
    else
      importer(field.type, value).import
    end
  end

  def target_class
    name = self.class.to_s.sub(/Importer\z/, '')
    ActiveSupport::Inflector.constantize(name)
  end

  def importer(target, value)
    name = target.to_s + 'Importer'
    ActiveSupport::Inflector.constantize(name).importer(value)
  end

  def fields
    FieldInspector.new.fields(target_class)
  end
end
