# General helpers for application views
module ApplicationHelper
  def page_title(page_title)
    content_for(:page_title) { page_title.html_safe }
  end

  def meta_title(meta_title)
    content_for(:meta_title) { meta_title.html_safe }
  end

  def meta_description(meta_description)
    content_for(:meta_description) { meta_description.html_safe }
  end

  def meta_image(meta_image)
    content_for(:meta_image) { meta_image.html_safe }
  end

  def current_url
    "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end

  def full_url(path)
    "#{request.protocol}#{request.host_with_port}#{path}"
  end

  # apply the strip_tags helper and also convert nbsp to a ' '
  def strip_tags_nbsp(text)
    if text.present?
      strip_tags(text.gsub('&nbsp;', ' '))
    end
  end

  # from http://www.kensodev.com/2012/03/06/better-simple_format-for-rails-3-x-projects/
  # same as simple_format except it does not wrap all text in p tags
  def simple_format_no_tags(text, _html_options = {}, options = {})
    text = '' if text.nil?
    text = smart_truncate(text, options[:truncate]) if options[:truncate].present?
    text = sanitize(text) unless options[:sanitize] == false
    text = text.to_str
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    #   text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text.html_safe
  end

  # sort the locales so the default locale is first and then the rest are alpha
  def sort_locales(locales)
    if locales.present?
      # sort
      locales.sort!

      # move default locale to first position
      default = locales.index{|x| x == I18n.default_locale}
      if default.present? && default > 0
        locales.unshift(locales[default])
        locales.delete_at(default+1)
      end
    end
    return locales
  end

  # format the true/false value into yes/no with box
  def format_boolean_flag(flag, small=false)
    css_small = small == true ? 'boolean-flag-xs' : ''
    if flag == true
      return "<div class='boolean-flag boolean-flag-true #{css_small}'>#{t('shared.common.yes')}</div>".html_safe
    else
      return "<div class='boolean-flag boolean-flag-false #{css_small}'>#{t('shared.common.no')}</div>".html_safe
    end
  end


end
