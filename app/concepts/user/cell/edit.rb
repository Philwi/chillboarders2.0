module User::Cell
  class Edit < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ::Chillboarders::Util::Layout
    include ::ActionView::Helpers
    include ActionView::Helpers::FormOptionsHelper
    include ::ActionView::Helpers::RenderingHelper
  end
end