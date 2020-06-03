class CommonsController < ApplicationController
  def privacy
    meta_tags(title: 'Chillboarders - Privacy Policy', description: 'privacy police of chillboarders', keywords: '')
    render html: concept(Chillboarders::Cell::Privacy), layout: 'application'
  end

  def impressum
    meta_tags(title: 'Chillboarders - Impressum', description: 'Impressum of chillboarders', keywords: '')
    render html: concept(Chillboarders::Cell::Impressum), layout: 'application'
  end

  def contact
    meta_tags(title: 'Chillboarders - Contact', description: 'Contact Chillboarders', keywords: '')
    render html: concept(Chillboarders::Cell::Contact, Contact.new), layout: 'application'
  end

  def create_contact_message
    result = Chillboarders::Operation::Contact::Create.(params: params)
    if result.success?
      flash[:notice] = I18n.t('.contact.save')
      redirect_to :new_user_session
    else
      render html: concept(Chillboarders::Cell::Contact, result['contract.default']), layout: 'application'
    end
  end
end