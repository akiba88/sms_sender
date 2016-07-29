require 'sms_sender/version'
require 'sms_sender/config'

require 'sms_sender/logger'
require 'sms_sender/process'

module SmsSender
  class << self
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

def require_all(_dir)
  Dir[File.expand_path(File.join(File.dirname(File.absolute_path(__FILE__)), _dir)) + "/**/*.rb"].each do |file|
    require file
  end
end

require 'sms_sender/models/log'

require_all 'sms_sender/providers'
require_all 'sms_sender/notifications'
