module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = "Events"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("nps.jpg", :alt => "Events!", :class => "round")
  end
end
