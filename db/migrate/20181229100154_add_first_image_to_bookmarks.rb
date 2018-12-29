class AddFirstImageToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :thumbnail, :string
  end
end
