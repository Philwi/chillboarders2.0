module UserMessage::Contract
  class Create < Reform::Form
    include Dry::Validation

    property :body
    property :for_user_id

    validates :body, length: 1..5000, presence: true
    validates :for_user_id, presence: true
  end
end
