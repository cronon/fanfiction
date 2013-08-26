json.array!(@books) do |book|
  json.extract! book, :title, :description
  json.url book_url(book, format: :json)
end
