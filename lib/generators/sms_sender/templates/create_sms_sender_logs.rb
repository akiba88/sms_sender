class CreateSmsSenderLogs < ActiveRecord::Migration
  def self.up
    create_table :sms_sender_logs do |t|
      t.string :phone_number
      t.text :content
      t.text :error_message
      t.string :status
      t.string :channel

      t.string :response
      t.string :status_delivery

      t.references :item, polymorphic: true, index: true

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :sms_sender_logs
  end
end