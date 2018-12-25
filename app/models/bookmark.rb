class Bookmark < ApplicationRecord
	acts_as_ordered_taggable
	belongs_to :user
	has_many :likes 
	validates :link, url: true
	before_create :set_metadata

	def set_metadata
		link_data = LinkThumbnailer.generate(self.link)
		self.title = link_data.title
		self.favicon = link_data.favicon
		self.description = link_data.description
	end
end
