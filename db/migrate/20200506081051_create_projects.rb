class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :laboratory, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
