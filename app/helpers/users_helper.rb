# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user, size: 80)
    image_tag(user.gravatar_url(size: size), alt: user.name, class: "gravatar")
  end
end
