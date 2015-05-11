json.array!(@articles) do |article|
  json.extract! article, :id, :title, :location, :excerpt, :body, :publish_at
  json.url article_url(article, format: :json)
end
