class Book < ActiveRecord::Base
	belongs_to :user
	acts_as_taggable
	acts_as_taggable_on :tags
end
