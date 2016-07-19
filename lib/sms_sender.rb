require 'sms_sender/version'
require 'sms_sender/logger'

require 'models/sms_log'

module SmsSender
  class << self
    def active_record_protected_attributes?
      @active_record_protected_attributes ||= !!defined?(ProtectedAttributes)
    end
  end
end
