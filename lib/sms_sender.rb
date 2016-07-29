require 'sms_sender/version'
require 'sms_sender/config'

require 'sms_sender/logger'
require 'sms_sender/process'

Dir["sms_sender/providers/*.rb"].each { |file| require file }
Dir["sms_sender/notifications/*.rb"].each { |file| require file }

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
      SmsSender.config.send_out
    end
  end
end

require 'sms_sender/models/log'
