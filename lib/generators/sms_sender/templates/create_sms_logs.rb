class CreateSmsLogs < ActiveRecord::Migration
  def self.up
    create_table :sms_logs do |t|
      t.string :phone_number
      t.text :content
      t.text :error_message
      t.string :status
      t.references :smsable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end

  def self.down
    drop_table :sms_logs
  end
end