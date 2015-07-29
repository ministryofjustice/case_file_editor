#!/usr/bin/env ruby
APP_PATH = File.expand_path('../../config/application',  __FILE__)
require_relative '../config/boot'
require APP_PATH
Rails.application.require_environment!

models = Dir['app/models/*.rb'].
  map { |f|
    snake_case = File.basename(f, '.rb')
    require snake_case

    klass =
      ActiveSupport::Inflector.constantize(
        ActiveSupport::Inflector.camelize(snake_case))
  }.
  select { |c| c.is_a?(Class) }

models.each do |klass|
  importer_class_name = "#{klass}Importer"
  snake_case = ActiveSupport::Inflector.underscore(importer_class_name)
  path = "app/importers/#{snake_case}.rb"
  puts path

  File.open(path, 'w') do |f|
    f.puts <<RUBY
class #{importer_class_name} < GenericImporter
end
RUBY
  end
end
