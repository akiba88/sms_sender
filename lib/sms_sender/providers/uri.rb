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

        # TODO customize id_transaction
        self.id_transaction = response.split('|').last
      end

      def get
        ::HTTP.get(request_url, params: request_params)
      end

      def get_status
        SmsSender::Providers::Status::Uri.get(id_transaction) if options['status_request'].present?
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
