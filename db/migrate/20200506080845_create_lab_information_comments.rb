class CreateLabInformationComments < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_information_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lab_information, null: false, foreign_key: true
      t.string :content, null: false

      t.timestamps
    end
  end
end
