module Chillboarders::Cell
  class Form < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ::Chillboarders::Util::Layout
    include ActionView::Helpers::FormOptionsHelper

    def path
      options[:path]
    end

    def attributes
      options[:attributes]
    end

    def submit_text
      options[:submit_text]
    end

    def background_image
      if image = options[:background_image]
        begin
          rails_blob_path(image , disposition: "attachment", only_path: true)
        rescue
          '/images/sign_in_image.jpg'
        end
      else
        '/images/sign_in_image.jpg'
      end
    end

    def method
      options[:method]
    end

    def as_model
      (model.try(:model) || model).model_name.param_key.to_sym
    end

    def container
      options[:container_id]
    end

    def card_class
      options[:card_class]
    end

    def form(f)
      form_input = ''
      form_input.concat(
        content_tag(:div, class: 'form-inputs') do
          form_output = ''
          attributes.map do |attribute|
            content_tag(:div, class: 'input-group mb3') do
              attributes_output = ''
              unless attribute[:hidden].present?
                attributes_output.concat(content_tag(:div, class: 'input-group-append') do
                  content_tag(:span, class: 'input-group-text') do
                    content_tag(:i, attribute[:icon], class: 'material-icons')
                  end
                end)
              end
              attributes_output.concat(
                case attribute[:type]
                when :attachment
                  f.file_field attribute[:attribute], attribute[:options]
                when :select
                  f.input attribute[:attribute], attribute[:options]
                else
                  f.input attribute[:attribute], attribute[:options]
                end
              )
            end
          end.join
        end)
      form_input.concat(content_tag(:div, class: 'form-actions') do
        content_tag(:div, class: 'd-flex justify-content-center mt-3 login_container') do
          f.button :submit, submit_text, class: 'btn login_btn'
        end
      end)
    end
  end
end