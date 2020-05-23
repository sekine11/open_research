class CreateLabMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :laboratory, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
