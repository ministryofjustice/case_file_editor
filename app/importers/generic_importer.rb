class GenericImporter
  def import(obj)
    target_class.new(params(obj))
  end

private

  def params(obj)
    fields.map { |f| import_field(f, obj) }.compact.to_h
  end

  def import_field(field, obj)
    key = field.name.to_s
    return nil unless obj.key?(key)

    if field.array?
      value = obj.fetch(key).map { |v| import_one(field, v) }
    else
      value = import_one(field, obj.fetch(key))
    end

    [field.name, value]
  end

  def import_one(field, value)
    if field.basic?
      value
    else
      importer(field.type).import(value)
    end
  end

  def target_class
    name = self.class.to_s.sub(/Importer\z/, '')
    ActiveSupport::Inflector.constantize(name)
  end

  def importer(target)
    name = target.to_s + 'Importer'
    ActiveSupport::Inflector.constantize(name).new
  end

  def fields
    FieldInspector.new.fields(target_class)
  end
end
