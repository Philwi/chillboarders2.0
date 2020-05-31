module UserMessage::Cell
  class Index < Trailblazer::Cell
    include ::ActionView::Helpers::JavaScriptHelper

    def user
      user = model[:user]
      if user.present?
        user
      else
        nil
      end
    end

    def javascript
      javascript_tag <<-JAVASCRIPT
        function removeValueFromBody(){
          var list = document.getElementsByClassName('user-message-body');
          var n;
          for (n = 0; n < list.length; ++n) {
              list[n].value='';
          }
        }
      JAVASCRIPT
    end
  end
end