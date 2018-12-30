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

require 'rails_helper'


RSpec.describe Bookmark, type: :model do
	it "is valid with thumbnail" do
		bookmark = Bookmark.new(link: "http://google.com", thumbnail: "http://google.com")
		expect(bookmark).to have_attributes(link: "http://google.com", thumbnail: "http://google.com")
	end
end
