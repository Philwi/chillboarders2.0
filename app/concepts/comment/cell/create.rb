module Comment::Cell
  class Create < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ::Chillboarders::Util::Layout
    include ActionView::Helpers::JavaScriptHelper

    def spot_id
      options[:spot_id]
    end

    def spots
      options[:spots]
    end

    def user_site_id
      options[:user_site_id]
    end

    def javascript
      javascript_tag <<-JAVASCRIPT
        function removeValueFromDescription(){
          var list = document.getElementsByClassName('comment_description');
          var n;
          for (n = 0; n < list.length; ++n) {
              list[n].value='';
          }
        }
      JAVASCRIPT
    end
  end
end