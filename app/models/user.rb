class User < ApplicationRecord
  acts_as_tagger
  has_many :bookmarks
  has_many :likes 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
