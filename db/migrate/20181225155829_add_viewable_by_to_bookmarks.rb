class AddViewableByToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :viewable_by, :integer
  end
end
