module Chillboarders::Cell
  class Footer < Trailblazer::Cell

    FOOTER_PATHS = [
      { text: '.footer.contact', path: :contact_commons, icon: 'email' },
      { text: '.footer.data_protection', path: :privacy_commons, icon: 'policy' },
      { text: '.footer.impressum', path: :impressum_commons, icon: 'import_contacts' },
    ].freeze

    def footer_paths
      FOOTER_PATHS.map do |path|
        build_navigtion_link(path)
      end.join
    end

    def build_navigtion_link(path)
      content_tag(:li, class: 'footer-item') do
        link_to(path[:path], class: 'footer-link', title: I18n.t(path[:text]), data: { toggle: 'tooltip', trigger: 'hover' }) do
          out = ''
          out.concat content_tag(:i, path[:icon] ,class: 'material-icons')
          out.concat content_tag(:p, I18n.t(path[:text]))
        end
      end
    end

    def existing_date
      if Date.today.year == 2020
        Date.today.year
      else
        " 2020 - #{Date.today.year}"
      end
    end

    def chillboarders_copyright
      out = ''
      out.concat content_tag(:i, 'copyright', class: 'material-icons d-inline')
      out.concat content_tag(:p, " #{existing_date}, Philipp Winkler. All rights reserved", class: 'd-inline')
    end
  end
end