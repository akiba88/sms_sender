require 'slack-notifier'

module Notifications
  class Slack
    attr_reader :object, :notifier

    def initialize(object)
      @object = object
      @notifier = ::Slack::Notifier.new(options[:path], channel: options[:channel], username: options[:username])
    end

    def run(title, fallback, type)
      notifier.ping notifier_params(title, fallback, type)
    end

  protected

    def options
      @options ||= SmsSender.config.notifications_options[:slack]
    end

    def notifier_params(title, fallback, type)
      {
        attachments: [
          {
            color: 'danger',
            title: title,
            title_link: options[:callback_url],
            fallback: fallback,
            fields: [
              {
                title: 'Type',
                value: type,
                short: true
              },
              {
                title: 'Environment',
                value: SmsSender.config.environment,
                short: true
              },
              {
                title: 'Project',
                value: SmsSender.config.project,
                short: true
              },
              {
                title: object.class.name,
                value: object.id,
                short: true
              }
            ]
          }
        ]
      }
    end
  end
end
