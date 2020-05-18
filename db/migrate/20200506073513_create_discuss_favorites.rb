class CreateDiscussFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :discuss_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :discussion, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :discussion_id], unique: true
    end
  end
end
