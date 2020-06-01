class CommonsController < ApplicationController
  def privacy
    render html: concept(Chillboarders::Cell::Privacy), layout: 'application'
  end

  def impressum
    render html: concept(Chillboarders::Cell::Impressum), layout: 'application'
  end

  def contact
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