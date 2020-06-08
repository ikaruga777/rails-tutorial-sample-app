json.extract! feed, :id, :content

json.picture_url feed.picture.url if feed.picture?

json.created_at_time_ago_in_words time_ago_in_words(feed.created_at)

json.user do
  json.extract! feed.user, :id, :name, :gravatar_url
  json.is_current_user current_user?(feed.user)
end
