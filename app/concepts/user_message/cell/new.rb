module UserMessage::Cell
  class New < Trailblazer::Cell
    include ::SimpleForm::ActionViewExtensions::FormHelper
    include ::ActionView::Helpers::FormOptionsHelper

  end
end