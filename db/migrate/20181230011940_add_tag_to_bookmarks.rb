class AddTagToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :tag_bookmark, :string
  end
end
