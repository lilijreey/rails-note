json.array!(@books) do |book|
  json.extract! book, :id, :name, :desc, :author
  json.url book_url(book, format: :json)
end
