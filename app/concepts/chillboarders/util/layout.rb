module Chillboarders::Util
  module Layout
    def flash_messages
      context[:controller].flash.map do |name, msg|
        name += ' alert-info' if name == 'notice'
        name = 'danger' if name == 'alert'
        content_tag(:div, class: "container alert alert-dismissable alert-#{name}") do
          content_tag(:button, content_tag(:i, 'close', class: 'material-icons'),
                      class: 'close', data: { dismiss: 'alert' }) +
            simple_format(msg)
        end
      end.join
    end
  end
end