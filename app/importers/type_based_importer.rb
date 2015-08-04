class TypeBasedImporter < GenericImporter
  def self.importer(source)
    klass = importer_class[source.fetch('type')]
    fail "#{self} can't import #{source.fetch('type')}" unless klass
    klass.new(source)
  end
end
