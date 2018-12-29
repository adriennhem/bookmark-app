require 'rails_helper'


RSpec.describe Bookmark, type: :model do
	it "is valid with thumbnail" do
		bookmark = Bookmark.new(link: "http://google.com", thumbnail: "http://google.com")
		expect(bookmark).to have_attributes(link: "http://google.com", thumbnail: "http://google.com")
	end
end