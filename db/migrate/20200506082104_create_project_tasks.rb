class CreateProjectTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :project_tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.string :content, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
