class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text :content
      t.references :bookmark, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
