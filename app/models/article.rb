class Article < ApplicationRecord
  belongs_to :bookmark
  belongs_to :user
  after_create :set_content

  def set_content 
  	bookmark = Bookmark.find_by_id(self.bookmark_id)
  	page = MetaInspector.new(bookmark.link) 
  	self.content = page.to_s
  end
end
