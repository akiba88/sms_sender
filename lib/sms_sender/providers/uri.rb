module SmsSender
  module Providers
    class Uri
      attr_reader :channel, :options

      attr_accessor :response, :id_transaction, :content, :phone_number

      def initialize(channel)
        @channel = channel
        @options = SmsSender.config.options[channel]
      end

      def run(text, phone_number)
        setup(text, phone_number)

        {
          response: response,
          status_delivery: get_status
        }
      end

    protected

      def setup(text, phone_number)
        self.content = text
        self.phone_number = phone_number

        self.response = get
        self.id_transaction = response.split('|').last
      end

      def get
        HTTP.get(main_request_url, params: main_request_params)
      end

      def get_status
        return nil if options['status_request'].nil?

        SmsSender::Providers::Uri::Status.get(id_transaction)
      end

      def request_url
        @request_path ||= options['main_request']['url']
      end

      def request_params
        return @request_params if defined?(@request_params)

        hash = options['main_request']['static']

        hash[options['main_request']['text_key']] = content
        hash[options['main_request']['phone_key']] = phone_number

        @request_params = hash
      end
    end
  end
end
