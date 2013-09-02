class Chapter < ActiveRecord::Base
	belongs_to :book
  validates :title, :content, :presence => true
end
