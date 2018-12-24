class AddActiveToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :active, :boolean, default: true
  end
end
