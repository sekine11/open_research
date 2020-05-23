class CreateProtocolFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :protocol_favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :protocol, null: false, foreign_key: true

      t.timestamps
    end
  end
end
