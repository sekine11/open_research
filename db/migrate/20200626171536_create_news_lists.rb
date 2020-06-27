class CreateNewsLists < ActiveRecord::Migration[5.2]
  def change
    create_table :news_lists do |t|
      t.string :title, null: false
      t.string :url, null: false
      t.string :published_at, null: false

      t.timestamps
    end
  end
end
