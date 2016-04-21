module FormattingHelper
  def format_textarea_input(x)
    Rinku.auto_link(simpler_format(x), :all, "rel='nofollow'").html_safe
  end

  def simpler_format(text)
    text = '' if text.nil?
    text = text.dup
    text = CGI::escapeHTML(text)
    text = text.to_str
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    text.gsub!(/\n\n+/, "<br /><br />")  # 2+ newline  -> br br
    text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text.html_safe
  end
end
