require 'savon'

module SmsSender
  module Providers
    class Soap
      attr_reader :channel

      def initialize(channel)
        @channel = channel
      end

      def run(text, phone_number)
        client.call(options['call_method']) do
          message(message_options(text, phone_number))
        end

        {}
      end

    protected

      def client
        @client ||= Savon.client(wdsl_options)
      end

      def options
        @options ||= SmsSender.config.options[channel]
      end

      def wdsl_options
        @wdsl_options ||= options['client_options']
      end

      def message_options(text, phone_number)
        return @message_options if defined?(@message_options)

        hash = options['message_options']['static']

        hash[options['message_options']['text_key']] = text
        hash[options['message_options']['phone_key']] = phone_number

        @message_options = hash
      end
    end
  end
end
