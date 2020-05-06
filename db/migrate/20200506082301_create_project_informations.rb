class CreateProjectInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :project_informations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :poject, null: false, foreign_key: true
      t.string :subject, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
