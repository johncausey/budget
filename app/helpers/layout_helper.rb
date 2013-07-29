module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
  
  def meta_description(arg)
    content_for(:meta_description) { h(arg.to_s)}
  end
  
  def meta_keywords(arg)
    content_for(:meta_keywords) { h(arg.to_s)}
  end
  
end
