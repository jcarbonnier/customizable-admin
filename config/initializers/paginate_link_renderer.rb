class PaginateLinkRenderer < WillPaginate::ActionView::LinkRenderer

  protected

  def page_number(page)
    unless page == current_page
      tag(:li, link(page, page, :rel => rel_value(page)))
    else
      tag(:li, tag(:span, page), :class => "active")
    end
  end

  def previous_or_next_page(page, text, classname)
    if page
      tag(:li, link(text, page), :class => classname)
    else
      tag(:li, tag(:span, text), :class => classname + ' disabled')
    end
  end

  def gap()
    text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
    tag(:li, tag(:span, text))
  end

  def html_container(html)
    tag(:ul, html, container_attributes)
  end

end
