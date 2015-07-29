class TypeBasedImporter < GenericImporter
  def self.importer(object)
    klass = importer_class[object.fetch('type')]
    fail "#{self} can't import #{object.fetch('type')}" unless klass
    klass.new(object)
  end
end
