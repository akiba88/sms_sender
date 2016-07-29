module Providers
  class Uri
    attr_reader :channel

    attr_accessor :response, :id_transaction, :content, :phone_number

    def initialize(channel)
      @channel = channel
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

    def options
      @options ||= SmsSender.config.options[channel.to_sym]
    end

    def get
      HTTP.get(main_request_url, params: main_request_params)
    end

    def get_status
      return nil if options[:status_request].nil?

      HTTP.get(status_request_url, params: status_request_params)
    end

    # ================ Main request parameters ================

    def main_request_url
      @main_request_path ||= options[:main_request][:url]
    end

    def main_request_params
      return @main_request_params if defined?(@main_request_params)

      hash = options[:main_request][:static]

      hash[options[:main_request][:text_key]] = content
      hash[options[:main_request][:phone_key]] = phone_number

      @main_request_params = hash
    end

    # ================ Status request parameters ================

    def status_request_url
      @main_request_path ||= options[:status_request][:url]
    end

    def status_request_params
      return @status_request_params if defined?(@status_request_params)

      hash = options[:status_request][:static]
      hash[options[:status_request][:id_key]] = id_transaction

      @status_request_params = hash
    end
  end
end
