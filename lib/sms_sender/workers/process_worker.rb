module SmsSender
  module Workers
    class ProcessWorker
      include Sidekiq::Worker

      sidekiq_options queue: :sms, retry: 5

      def perform(object_class, object_id, args)
        object = Object.const_get(object_class).find(object_id)

        SmsSender::Process.new(args[:channel]).run(object, args[:message], args[:phone_number])
      end
    end
  end
end
