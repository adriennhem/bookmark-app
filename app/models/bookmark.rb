# == Schema Information
#
# Table name: bookmarks
#
#  id           :integer          not null, primary key
#  link         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  title        :string
#  description  :string
#  favicon      :string
#  user_id      :integer
#  active       :boolean          default(TRUE)
#  viewable_by  :integer
#  thumbnail    :string
#  host         :string
#  tag_bookmark :string
#

class Bookmark < ApplicationRecord
	include AlgoliaSearch
	  acts_as_taggable_on :tags

	belongs_to :user
	has_one :like 
	validates :link, url: true
	before_create :set_metadata
	before_save :set_tag_owner
	# before_save :set_tag_owner

	algoliasearch do
		attribute :title, :description, :link, :viewable_by, :active, :tag_bookmark

		searchableAttributes ['title', 'description', 'link', 'tag_bookmark']
	end

	def set_metadata
		paga = MetaInspector.new(self.link)
		self.title = paga.title
		self.description = paga.best_description
		self.favicon = paga.images.favicon
		self.thumbnail = paga.images.first
	end

	def set_tag_owner
 #    # Set the owner of some tags based on the current tag_list
      # set_owner_tag_list_on(self.user, :tags, self.tag_list)
 #    # Clear the list so we don't get duplicate taggings
      self.tag_list = nil
  	end
end
