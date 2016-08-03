require 'singleton'

class SmsSender::Config
  include Singleton

  attr_reader :environment, :project, :options, :notifications_options, :send_out

  def available_channels
    [:main, :backup]
  end

  def options=(options = {})
    @options = options
  end

  def environment=(env)
    @environment = env
  end

  def project=(title)
    @project = title
  end

  def notifications_options=(options = {})
    @notifications_options = options
  end

  def send_out=(val)
    @send_out = val
  end
end
