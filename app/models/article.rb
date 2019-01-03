# == Schema Information
#
# Table name: articles
#
#  id          :integer          not null, primary key
#  content     :text
#  bookmark_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Article < ApplicationRecord
  belongs_to :bookmark
  belongs_to :user
  after_create :set_content

  def set_content 
  	article = MercuryParser.parse(self.bookmark.link) 
  	self.update_attribute(:content, article.content)
  end


end
