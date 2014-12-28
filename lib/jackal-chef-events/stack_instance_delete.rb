require 'jackal-chef-events'

module Jackal
  module ChefEvents

    class StackInstanceDelete < Jackal::Callback

      # Load and configure chef
      def setup(*_)
        require 'chef'
        config_path = config.fetch(
          :chef_events, :chef_config_path,
          '/etc/chef-server/jackal-client.rb'
        )
        content = File.read(config_path)
        Chef::Config.from_string(content, config_path)
      end

      # Check if message is valid
      def valid?(*_)
        super do |payload|
          payload.get(:data, :cfn_event, :resource_type) == 'AWS::EC2::Instance' &&
            payload.get(:data, :cfn_event, :resource_status) == 'DELETE_COMPLETE'
        end
      end

      # Scrub chef data for instance
      #
      # @param message [Carnivore::Message]
      def execute(message)
        failure_wrap do
          instance_id = payload.get(:data, :cfn_event, :physical_resource_id)
          nodes = Chef::Search::Query.new.search(
            :node, "#{config[:instance_id_solr]}:#{instance_id.tr(':', '*')}"
          )
          nodes.each do |node|
            api_client = Chef::ApiClient.load(node.name)
            if(api_client)
              debug "Deleting chef API client #{api_client.name}"
              api_client.delete
            end
            debug "Deleting chef API node #{node.name}"
            node.delete
          end
          info "Deleted node and client (#{node.size} items) data related to instance ID: #{instance_id}"
        end
      end

    end
  end
end
