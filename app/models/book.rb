class Book < ActiveRecord::Base
	belongs_to :user
	has_many :chapters, dependent: :destroy
	acts_as_taggable
	acts_as_taggable_on :tags
	acts_as_votable
	is_impressionable
end
