class Bookmark < ApplicationRecord
	include AlgoliaSearch
	acts_as_ordered_taggable
	belongs_to :user
	has_one :like 
	validates :link, url: true
	before_create :set_metadata

	algoliasearch do
		attribute :title, :description, :link, :tag_list, :viewable_by, :active

	end

	def set_metadata
		link_data = LinkThumbnailer.generate(self.link)
		self.title = link_data.title
		self.favicon = link_data.favicon
		self.description = link_data.description
	end
end
