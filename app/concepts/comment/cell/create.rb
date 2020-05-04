module Comment::Cell
  class Create < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ::Chillboarders::Util::Layout

    def spot_id
      options[:spot_id]
    end

    def description
    end
  end
end