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

require 'test_helper'

class BookmarkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
