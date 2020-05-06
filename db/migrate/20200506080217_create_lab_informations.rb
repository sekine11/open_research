class CreateLabInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_informations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :laboratory, null: false, foreign_key: true
      t.string :subject, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
