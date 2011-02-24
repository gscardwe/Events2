module EventsHelper
  def gravatar_for_e(event, options = { :size => 50 })
    gravatar_image_tag(event.name.downcase, :alt => event.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
end
