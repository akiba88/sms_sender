require 'active_record'

class SmsLog < ActiveRecord::Base
  # attr_accessible :phone_number, :content, :status, :error_message

  belongs_to :smsable, polymorphic: true

  scope :error, -> { where(status: 'error') }
  scope :success, -> { where(status: 'success') }
  scope :ordered, -> { order(created_at: :desc) }

  def success?
    status == 'success'
  end

  def error?
    status == 'error'
  end
end
