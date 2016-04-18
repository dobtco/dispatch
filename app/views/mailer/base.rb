class Views::Mailer::Base < Views::Base
  def content
    rawtext '<!doctype html>'
    html {
      head {
        title message.subject
        meta_tags
        stylesheets
      }

      body {
        render_layout
      }
    }
  end

  def meta_tags
    meta name: 'viewport', content: 'width=device-width'
    meta 'http-equiv' => 'Content-Type', content: 'text/html; charset=UTF-8'
  end

  def stylesheets
    stylesheet_link_tag 'mailer', media: 'all'
  end

  def render_layout
    table(class: 'body-wrap') {
      tr {
        td
        td(class: 'header_container') {
          render_header
        }
        td
      }
      tr {
        td
        td(class: 'container') {
          div(class: 'content') {
            table {
              tr {
                td {
                  main
                }
              }
            }
          }
        }
        td
      }
    }

    table(class: 'footer-wrap') {
      tr {
        td
        td(class: 'container') {
          div(class: 'content') {
            table {
              tr {
                td(align: 'center') {
                  render_footer
                }
              }
            }
          }
        }
        td
      }
    }
  end

  def render_header
    h1('Beacon', class: 'site_name')
  end

  def render_footer
  end
end
