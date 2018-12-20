module Salesmate
  class Client
    attr_reader :base_url, :app_private_key, :session_token, :app_access_key

    def initialize(options = {})
      @base_url = options[:base_url]
      @app_private_key = options[:app_private_key]
      @session_token = options[:session_token]
      @app_access_key = options[:app_access_key]
    end

    def connection
      @connection ||= Faraday.new connection_options do |conn|
        conn.adapter Faraday.default_adapter
      end
    end

    def self.resources
      {}
    end

    def method_missing(name, *args, &block)
      if self.class.resources.key?(name)
        resources[name] ||= self.class.resources[name].new(connection: connection)
        resources[name]
      else
        super
      end
    end

    def respond_to_missing?(name, include_private = false)
      self.class.resources.key?(name) || super
    end

    def resources
      @resources ||= {}
    end

    def default_user_agent
      "Salesmate Ruby SDK/#{Salesmate::VERSION} Faraday/#{Faraday::VERSION}"
    end

    private

    def connection_options
      {
        url: base_url,
        headers: {
          content_type: 'application/json',
          'AppPrivateKey': app_private_key,
          'SessionToken': session_token,
          'AppAccessKey': app_access_key,
          user_agent: default_user_agent.to_s.strip
        }
      }
    end
  end
end
