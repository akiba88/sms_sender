class SmsSender::Process
  attr_reader :channel, :provider

  attr_accessor :callback, :object, :content, :phone_number

  def initialize(channel)
    @channel = channel
    @provider = SmsSender.config.options[channel]['provider']
    @callback = {}
  end

  def run(object, message, phone_number)
    setup(object, message, phone_number)

    begin
      send_process

      return true
    rescue => e
      fail_process(e)
      
      return false
    end
  end

protected

  def setup(object, message, phone_number)
    self.object = object
    self.content = message
    self.phone_number = phone_number
  end

  def logger
    @logger ||= SmsSender::Logger.new(object)
  end

  def send_process
    if SmsSender.send_out?
      self.callback = Object.const_get("SmsSender::Providers::#{provider.capitalize}").new(channel).run(content, phone_number)
    else
      puts "SMS: '#{content}'"
    end

    logger.success{
      {
        content: content,
        phone_number: phone_number,
        channel: channel,
        response: callback[:response],
        status_delivery: callback[:status_delivery]
      }
    }
  end

  def fail_process(e)
    logger.error{ 
      { 
        content: content, 
        phone_number: phone_number, 
        error_message: e.message, 
        channel: channel, 
        response: callback[:response], 
        status_delivery: callback[:status_delivery] 
      } 
    }

    send_notification if SmsSender.send_out?
  end

  def send_notification
    Notifications::Slack.new(object).run(slack_title, slack_fallback, 'send_sms')
  end

  def slack_title
    'Failed to send sms'
  end
  
  def slack_fallback
    "[#{SmsSender.config.project}] Failed to send sms for #{object.class.name} ##{object.id}"
  end
end
