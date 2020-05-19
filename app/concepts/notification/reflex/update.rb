module Notification::Reflex
  class Update < ApplicationReflex
    def mark_as_seen
      Notification.find_by(id: element.dataset['notification-id']).update(seen: true)
    end
  end
end