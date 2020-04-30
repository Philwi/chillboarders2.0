module User::Cell
  class Create < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::UrlHelper
    include ::ActionView::Helpers::AssetTagHelper
    include ::Chillboarders::Util::Layout
  end
end