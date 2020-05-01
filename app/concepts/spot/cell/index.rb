module Spot::Cell
  class Index < Trailblazer::Cell
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper

    def spots
      content_tag(:div, class: 'container') do
        content_tag(:div, class: 'row') do
          model.map do |spot|
            content_tag(:div, class: 'col-md') do
              single_spot(spot)
            end
          end.join
        end
      end
    end

    def single_spot(spot)
      content_tag(:div, class: 'card', style: 'width: 18rem;') do
        output = ''
        output.concat image_tag(spot&.images&.first || "sign_in_image.jpg", class: 'card-img-top', alt: 'Spotimage')
        output.concat(content_tag(:div, class: 'card-body') do
          inner = ''
          inner.concat content_tag(:h5, spot.title, class: 'card-title')
          inner.concat content_tag(:p, spot.description, class: 'card-text')
        end)
        output.concat(content_tag(:ul, class: 'list-group list-group-flush') do
          content_tag(:li, spot.type, class: 'list-group-item')
        end)
        output.concat(content_tag(:div, class: 'card-body') do
          link_to I18n.t('.spots.to_spot'), edit_spot_path(spot.id), class: 'card-link'
        end)
      end
    end
  end
end