require 'rails/generators'
require 'rails/generators/active_record'

class SmsSender::Generators::InstallGenerator < ::Rails::Generators::Base
  include ::Rails::Generators::Migration

  source_root File.expand_path('../templates', __FILE__)

  desc "Generates (but does not run) a migration to add a 'sms_sender_logs' table."

  def create_migration_file
    add_or_skip_migration('create_sms_sender_logs')
  end

  def self.next_migration_number(dirname)
    ::ActiveRecord::Generators::Base.next_migration_number(dirname)
  end

protected

  def add_or_skip_migration(template)
    migration_dir = File.expand_path('db/migrate')

    if self.class.migration_exists?(migration_dir, template)
      ::Kernel.warn "Migration already exists: #{template}"
    else
      migration_template "#{template}.rb", "db/migrate/#{template}.rb"
    end
  end
end
