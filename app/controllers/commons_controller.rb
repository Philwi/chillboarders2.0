class CommonsController < ApplicationController
  def privacy
    meta_tags(title: I18n.t('seo.controller.common.privacy.title'), description: I18n.t('seo.controller.common.privacy.description'), keywords: I18n.t('seo.controller.common.privacy.keywords'))
    render html: concept(Chillboarders::Cell::Privacy), layout: 'application'
  end

  def impressum
    meta_tags(title: I18n.t('seo.controller.common.impressum.title'), description: I18n.t('seo.controller.common.impressum.description'), keywords: I18n.t('seo.controller.common.impressum.keywords'))
    render html: concept(Chillboarders::Cell::Impressum), layout: 'application'
  end

  def contact
    meta_tags(title: I18n.t('seo.controller.common.contact.title'), description: I18n.t('seo.controller.common.contact.description'), keywords: I18n.t('seo.controller.common.contact.keywords'))
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