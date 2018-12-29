class Bookmark < ApplicationRecord
	include AlgoliaSearch
	acts_as_taggable_on :tags
	before_save :set_tag_owner
	belongs_to :user
	has_one :like 
	validates :link, url: true
	before_create :set_metadata

	algoliasearch do
		attribute :title, :description, :link, :tag_list, :viewable_by, :active

	end

	def set_metadata
		page = MetaInspector.new(self.link)
		self.title = page.title
		self.description = page.best_description
		self.favicon = page.images.favicon
	end

	def set_tag_owner
    # Set the owner of some tags based on the current tag_list
    set_owner_tag_list_on(self.user, :tags, self.tag_list)
    # Clear the list so we don't get duplicate taggings
    self.tag_list = nil
  end
end
