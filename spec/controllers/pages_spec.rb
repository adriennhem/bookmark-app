require 'rails_helper'

RSpec.describe PagesController do 
	it "renders the home template" do
		get :home 
		expect(response).to render_template("home")
	end
	it "render the website template" do
		get :home 
		expect(response).to render_template("layouts/website")
	end
end
