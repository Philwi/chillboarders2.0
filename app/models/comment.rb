class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :spot, optional: true
  belongs_to :user_site, optional: true
  belongs_to :active_storage_attachments, optional: true
end
