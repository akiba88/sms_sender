require 'rails_helper'
require 'generator_spec'
require File.expand_path('../../../lib/generators/sms_sender/install_generator', __FILE__)

describe SmsSender::InstallGenerator, type: :generator do
  destination File.expand_path('../../tmp', __FILE__)

  after(:all) { prepare_destination }

  describe 'no options' do
    before(:all) do
      prepare_destination
      run_generator
    end

    it "generates a migration for creating the 'sms_sender_logs' table" do
      expect(destination_root).to have_structure {
                                    directory 'db' do
                                      directory 'migrate' do
                                        migration 'create_sms_sender_logs' do
                                          contains 'class CreateSmsSenderLogs'
                                          contains 'create_table :sms_sender_logs'
                                          contains 't.references :item, polymorphic: true, index: true'
                                        end
                                      end
                                    end
                                  }
    end
  end
end
