$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'jackal-chef-events/version'
Gem::Specification.new do |s|
  s.name = 'jackal-chef-events'
  s.version = Jackal::ChefEvents::VERSION.version
  s.summary = 'Chef events processor'
  s.author = 'Chris Roberts'
  s.email = 'code@chrisroberts.org'
  s.homepage = 'https://github.com/carnivore-rb/jackal-chef-events'
  s.description = 'Chef events processor'
  s.require_path = 'lib'
  s.license = 'Apache 2.0'
  s.add_dependency 'jackal'
  s.files = Dir['lib/**/*'] + %w(jackal-chef-events.gemspec README.md CHANGELOG.md CONTRIBUTING.md LICENSE)
end
