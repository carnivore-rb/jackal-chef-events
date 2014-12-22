require 'jackal'
require 'jackal-chef-events/version'

module Jackal
  module ChefEvents
    autoload :StackDelete, 'jackal-chef-events/stack_delete'
    autoload :StackInstanceDelete, 'jackal-chef-events/stack_instance_delete'
  end
end
