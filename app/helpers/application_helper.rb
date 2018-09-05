module ApplicationHelper
  def full_title page_title
    base_title = t "layouts.users.title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def format_time time
    time.strftime("%d/%m/%Y %H:%M")
  end

  def format_time_post time
    time.strftime("%d %b %Y")
  end

  def count_index_list index
    index + 1
  end
end
