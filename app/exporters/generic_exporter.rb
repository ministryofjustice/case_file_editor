class GenericExporter
  def self.attributes(*names)
    @attributes ||= []
    @attributes += names
    @attributes
  end

  def initialize(object)
    @object = object
  end

  def export
    self.class.attributes.map { |name|
      [name, exporter(@object.public_send(name)).export]
    }.reject { |_, v| v.nil? || v == [] }.to_h
  end

private

  attr_reader :object

  def exporter(obj)
    "#{obj.class}Exporter".constantize.new(obj)
  end
end
