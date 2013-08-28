json.array!(@chapters) do |chapter|
  json.extract! chapter, :title, :content, :book_id
  json.url chapter_url(chapter, format: :json)
end
