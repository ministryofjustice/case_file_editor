class GenericExporter
  def self.attributes(*names)
    @attributes ||= []
    @attributes += names
    @attributes
  end

  def self.exporter(obj)
    "#{obj.class}Exporter".constantize.new(obj)
  end

  def initialize(object)
    @object = object
  end

  def export
    self.class.attributes.
      map { |name| [name.to_s, exporter(@object.public_send(name)).export] }.
      reject { |_, v| v.nil? || v == [] }.to_h
  end

private

  attr_reader :object

  def exporter(obj)
    self.class.exporter(obj)
  end
end
