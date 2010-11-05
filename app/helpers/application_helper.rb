module ApplicationHelper
  GRAVATAR_BASE_URL = 'http://www.gravatar.com/avatar'
  def gravatar_url(gravatar_id, options)
    options = options.reverse_merge('d' => 'mm')
    query_string = options.to_query
    "#{GRAVATAR_BASE_URL}/#{gravatar_id}?#{query_string}"
  end

  GITHUB_BASE_URL = 'https://github.com'
  def github_url(github_username)
    "#{GITHUB_BASE_URL}/#{github_username}"
  end
end
