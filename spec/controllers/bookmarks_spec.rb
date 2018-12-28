require 'rails_helper'

RSpec.describe BookmarksController do
	login_user 

	it "renders bookmark index after create" do
		post :create, params: { bookmark: { title: "hello", link: "http://www.google.com" } }
		expect(response).to redirect_to(bookmarks_path)
	end
end