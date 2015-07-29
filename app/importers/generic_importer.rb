class GenericImporter
  def initialize(object)
    @object = object
  end

  def import
    target_class.new(params)
  end

private

  attr_reader :object

  def params
    fields.map { |f| import_field(f) }.compact.to_h
  end

  def import_field(field)
    key = field.name.to_s
    return nil unless object.key?(key)

    if field.array?
      value = object.fetch(key).map { |v| import_one(field, v) }
    else
      value = import_one(field, object.fetch(key))
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
    ActiveSupport::Inflector.constantize(name).new(value)
  end

  def fields
    FieldInspector.new.fields(target_class)
  end
end
