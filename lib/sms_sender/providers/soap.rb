require 'savon'

module SmsSender
  module Providers
    class Soap
      attr_reader :channel, :options

      def initialize(channel)
        @channel = channel
        @options = SmsSender.config.options[channel]
      end

      def run(text, phone_number)
        {
          response: client.call(options['call_method'].to_sym, message: message_options(text, phone_number))
        }
      end

    protected

      def client
        @client ||= Savon.client(wdsl_options)
      end

      def wdsl_options
        return @wdsl_options if defined?(@wdsl_options)

        @wdsl_options = options['client_options']
        @wdsl_options['ssl_verify_mode'] = @wdsl_options['ssl_verify_mode'].to_sym if @wdsl_options.has_key?('ssl_verify_mode')
        @wdsl_options
      end

      def message_options(text, phone_number)
        return @message_options if defined?(@message_options)

        hash = options['message_options'].fetch('static', {})

        hash[options['message_options']['text_key']] = text
        hash[options['message_options']['phone_key']] = phone_number

        @message_options = hash
      end
    end
  end
end
