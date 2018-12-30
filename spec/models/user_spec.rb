# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, :type => :model do
  it "is valid with valid attributes" do
  	user = User.new(email: "adrien@gmail.com", password: "hello123", password_confirmation: "hello123")
  	expect(user).to be_valid
  end
  it "is not valid without a email" do 
  	user = User.new(email: nil, password: "hello123", password_confirmation: "hello123")
  	expect(user).not_to be_valid
  end
  it "is not valid without a valid email" do 
  	user = User.new(email: "adriennhem", password: "hello123", password_confirmation: "hello123")
  	expect(user).not_to be_valid
  end
  it "is not valid without a password" do
  	user = User.new(email: nil, password: nil, password_confirmation: "hello123")
  	expect(user).not_to be_valid
  end
  it "is not valid without password_confirmation" do
  	user = User.new(email: nil, password: "hello123", password_confirmation: nil)
  	expect(user).not_to be_valid
  end
end
