class Views::Layouts::Application < Views::Base
  attr_accessor :registered_widgets

  SITE_TITLE = 'Beacon'

  def javascripts
    script(src: '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js') unless Rails.env.test?
    script %Q{window.jQuery || document.write('<script src="/non_digest_assets/jquery.js"><\\/script>')}.html_safe

    unless Rails.env.test?
      script src: "//use.typekit.net/ckb1dps.js"
      script "try{Typekit.load();}catch(e){}".html_safe
    end

    javascript_include_tag 'application', 'data-turbolinks-track' => true, crossorigin: 'anonymous'
  end

  def stylesheets
    stylesheet_link_tag "application", media: "all", 'data-turbolinks-track' => true
    link rel: 'icon', type: 'image/png', href: '/apple-touch-icon-precomposed.png'
  end

  def meta_tags
    meta name: 'viewport', content: 'width=device-width, initial-scale=1.0'
    csrf_meta_tags
  end

  def content
    rawtext "<!doctype html>"

    html {
      head {
        title calculated_page_title
        stylesheets
        javascripts
        rawtext include_dobt_auth_header
        meta_tags
        rawtext '<!--[if lt IE 9]><script src="//d2yxgjkkbvnhdt.cloudfront.net/dist/shim.js"></script><![endif]-->'
      }

      body(
        class: parameterized_controller_and_action,
        'data-page-key' => parameterized_controller_and_action
      ) {
        widget Dvl::Core::Views::Flashes.new(flash: flash)

        main

        widget Dvl::Core::Views::Footer.new(application_name: 'Beacon')
        render_widgets(:modals)
        rawtext '<!--[if lt IE 9]><script src="//d2yxgjkkbvnhdt.cloudfront.net/dist/polyfills.js"></script><![endif]-->'
        rawtext include_dobt_auth_footer
      }
    }
  end

  def output_later(key, html)
    self.registered_widgets ||= {}
    self.registered_widgets[key] ||= []
    self.registered_widgets[key] << html
  end

  def register_modal(id, title, &block)
    output_later :modals, capture {
      widget Dvl::Core::Views::Modal.new(title: title, id: id, &block)
    }
  end

  def render_widgets(key)
    rawtext Array(registered_widgets.try(:[], key)).join('')
  end

  def page_title; end;

  def calculated_page_title
    if page_title.present?
      "#{page_title} - #{SITE_TITLE}"
    else
      SITE_TITLE
    end
  end

  private

  def parameterized_controller_and_action
    self.class.name.gsub('Views::', '').downcase.gsub('::', '-')
  end
end
