module ApplicationHelper
  #タイトルを入れるよ
  def full_title(page_title="")
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty? then
      return base_title
    else
      return page_title + " | " + base_title
    end
  end
end
