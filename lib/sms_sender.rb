require 'sms_sender/version'
require 'sms_sender/config'
require 'sms_sender/logger'
require 'sms_sender/process'

require 'sms_sender/models/log'

module SmsSender
  class << self
    # attr_reader :config

    def active_record_protected_attributes?
      @active_record_protected_attributes ||= !!defined?(ProtectedAttributes)
    end

    def config
      @config ||= SmsSender::Config.instance
      yield @config if block_given?
      @config
    end

    def send_out?
      SmsSender.config.environment == 'production'
    end
  end
end
