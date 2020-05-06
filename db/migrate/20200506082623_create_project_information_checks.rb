class CreateProjectInformationChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :project_information_checks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :poject_information, null: false, foreign_key: true

      t.timestamps
    end
  end
end
