class AddHostToBookmarks < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :host, :string
  end
end
