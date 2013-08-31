class Widget < ActiveRecord::Base
  is_impressionable

  def impressionist_count
    impressions.size
  end
 end