class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :laboratory, null: false, foreign_key: true
      t.string :title, null: false
      t.datetime :start, null: false
      t.datetime :end, null: false

      t.timestamps
    end
  end
end
