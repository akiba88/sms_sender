class SmsSender::Process
  attr_reader :channel, :provider

  def initialize(channel)
    @channel = channel
    @provider = SmsSender.config.options[channel.to_sym][:provider]
  end

  def run(object, message, phone_number)
    begin
      send_process(message, phone_number)
      logger(object).success{ { content: message, phone_number: phone_number, channel: channel } }
      return true
    rescue => e
      # send_notification if Rails.env.production?
      logger(object).error{ { content: message, phone_number: phone_number, error_message: e.message, channel: channel } }
      return false
    end
  end

protected

  def send_process(message, phone_number)
    if SmsSender.send_out?
      Object.const_get("SmsSender::Providers::#{provider.capitalize}").new(channel).run(message, phone_number)
    else
      puts "SMS: '#{message}'"
    end
  end

  # def send_notification
  #   # SmsSender::Notification::Slack.new(object).run(slack_title, slack_fallback, 'send_sms')
  # end

  def logger(object)
    @logger ||= SmsSender::Logger.new(object)
  end

  # def slack_title
  #   'Failed to send sms'
  # end
  #
  # def slack_fallback
  #   "[VN] Failed to send sms for #{object.class.name} ##{object.id}"
  # end
end
