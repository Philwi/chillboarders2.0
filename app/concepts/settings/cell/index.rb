module Settings::Cell
  class Index < Trailblazer::Cell

    SIGNED_IN_PATHS = [
      { text: '.navigation.user_site.edit', path: :edit_user_sites, svg: 'svgs/skater.svg' },
      { text: '.navigation.user.edit', path: :edit_user_registration, svg: 'svgs/edit.svg' },
      { text: '.navigation.sign_out', path: :destroy_user_session, svg: 'svgs/logout.svg' }
    ].freeze

    def setting_navigation
      content_tag(:ul, class: 'settings-nav') do
        SIGNED_IN_PATHS.map do |path|
          content_tag(:li) do
            link_to(I18n.t(path[:text]), path[:path], class: 'settings-nav-link', title: I18n.t(path[:text]))
          end
        end.join
      end
    end
  end
end