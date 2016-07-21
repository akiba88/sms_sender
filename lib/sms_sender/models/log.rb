require 'active_record'

class SmsSender::Log < ActiveRecord::Base
  self.table_name = 'sms_sender_logs'

  if ::SmsSender.active_record_protected_attributes?
    attr_accessible(:phone_number, :content, :channel, :status, :error_message, :response, :status_delivery)
  end

  belongs_to :item, polymorphic: true

  scope :error, -> { where(status: 'error') }
  scope :success, -> { where(status: 'success') }
  scope :ordered_by_created_at, -> { order(created_at: :desc) }

  def success?
    status == 'success'
  end

  def error?
    status == 'error'
  end
end
