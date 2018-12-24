class Bookmark < ApplicationRecord
	validates :link, url: true
end
