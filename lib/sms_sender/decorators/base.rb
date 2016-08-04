require 'draper'

class SmsSender::BaseDecorator < Draper::Decorator
end

class SmsSender::PaginationDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value, :entry_name, :total_count, :offset_value, :last_page?

  def source
    instance_variable_get(:@object)
  end
end