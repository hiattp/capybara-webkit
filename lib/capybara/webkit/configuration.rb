module Capybara
  module Webkit
    class Configuration
      class << self
        private

        def instance
          @instance ||= new
        end
      end

      def self.to_hash
        instance.freeze.to_hash
      end

      def self.modify
        if instance.frozen?
          raise "All configuration must take place before the driver starts"
        else
          yield instance
        end
      end

      attr_accessor :allowed_urls
      attr_writer :block_unknown_urls
      attr_accessor :blocked_urls
      attr_accessor :debug
      attr_writer :ignore_ssl_errors
      attr_accessor :timeout

      def initialize
        @allowed_urls = []
        @blocked_urls = []
        @block_unknown_urls = false
        @debug = false
        @ignore_ssl_errors = false
        @timeout = -1
      end

      def allow_url(url)
        @allowed_urls << url
      end

      def block_url(url)
        @blocked_urls << url
      end

      def block_unknown_urls
        @block_unknown_urls = true
      end

      def block_unknown_urls?
        @block_unknown_urls
      end

      def allow_unknown_urls
        allow_url("*")
      end

      def ignore_ssl_errors
        @ignore_ssl_errors = true
      end

      def ignore_ssl_errors?
        @ignore_ssl_errors
      end

      def to_hash
        {
          allowed_urls: allowed_urls,
          block_unknown_urls: block_unknown_urls?,
          blocked_urls: blocked_urls,
          debug: debug,
          ignore_ssl_errors: ignore_ssl_errors?,
          timeout: timeout
        }
      end
    end
  end
end
