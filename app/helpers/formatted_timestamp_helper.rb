module FormattedTimestampHelper
  def long_timestamp(time)
    formatted_timestamp(time, :long)
  end

  def short_timestamp(time)
    formatted_timestamp(time, :short)
  end

  def relative_timestamp(time)
    formatted_timestamp(time, :relative)
  end

  private

  def formatted_timestamp(time, format)
    # If we're in the current year, don't display the year
    if format == :long && time.year == Time.now.year
      format = :long_no_year
    end

    text_version = if format == :relative
                     time_ago_in_words(time)
                   else
                     time.strftime(I18n.t("time.formats.#{format}"))
                   end

    "<time data-formatted-timestamp='#{format}' datetime='#{time.iso8601}'>" \
    "#{text_version}</time>".html_safe
  end
end
