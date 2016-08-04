class SmsSender::LogDecorator < SmsSender::BaseDecorator
  delegate_all

  def display_status_label
    return h.content_tag(:span, 'Success', class: 'label label-success') if success?

    h.content_tag(:span, 'Error', class: 'label label-danger')
  end
end
