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

  def exporter(object)
    "#{object.class}Exporter".constantize.new(object)
  end
end
