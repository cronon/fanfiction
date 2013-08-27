ThinkingSphinx::Index.define :book, :with => :active_record do
  # fields
  indexes title, description

  # attributes
  #has created_at, updated_at
end