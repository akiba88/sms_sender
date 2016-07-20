require 'singleton'

class SmsSender::Config
  include Singleton

  attr_reader :environment, :options

  def options=(options = {})
    @options = options
  end

  def environment=(env)
    @environment = env
  end
end
