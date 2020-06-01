module Chillboarders::Cell
  class Contact < Trailblazer::Cell
    def form
      attributes = [
        { attribute: :name, icon: 'subject', options: { required: true, autofocus: true, label: false, placeholder: I18n.t('.contact.name')} },
        { attribute: :email, icon: 'email', options: { required: true, autofocus: true, label: false, placeholder: I18n.t('.contact.email')} },
        { attribute: :body, icon: 'view_headline', options: { as: :text, required: true, label: false, placeholder: I18n.t('.contact.body') } },
      ]
      ::Chillboarders::Cell::Form.(model, attributes: attributes, path: :create_contact_message_commons, container_id: 'login_container', card_class: 'user_card sign_up', submit_text: I18n.t('.misc.send'), context: context)
    end
  end
end