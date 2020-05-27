class CreateLabInformationChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :lab_information_checks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :lab_information, null: false, foreign_key: true

      t.timestamps
      t.index [:user_id, :lab_information_id], unique: true
    end
  end
end
