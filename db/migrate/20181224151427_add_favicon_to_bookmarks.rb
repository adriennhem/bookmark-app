class AddFaviconToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :favicon, :string
  end
end
