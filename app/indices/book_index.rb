ThinkingSphinx::Index.define :book, :with => :active_record do
  # fields
  indexes title
  indexes description

  # attributes
  has created_at, updated_at
end