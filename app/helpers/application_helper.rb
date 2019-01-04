module ApplicationHelper

#Title for pages that by accident may not have one
  def full_title(page_title = '')
    base_title = "Fabulari"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

end
