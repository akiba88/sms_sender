class SmsSender::Logger
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def success(&blk)
    store(:success, &blk)
  end

  def error(&blk)
    store(:error, &blk)
  end

protected

  def store(status, &blk)
    result = blk.call

    phone_number = result.try(:fetch, :phone_number, nil)
    content = result.try(:fetch, :content, nil)
    error_message = result.try(:fetch, :error_message, nil)
    channel = result.try(:fetch, :channel, nil)

    response = result.try(:fetch, :response, nil)
    status_delivery = result.try(:fetch, :status_delivery, nil)

    object.sms_logs.create(
      phone_number: phone_number,
      content: content,
      error_message: error_message,
      channel: channel,
      status: status,
      response: response,
      status_delivery: status_delivery
    )
  end
end
