class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subject, null: false
      t.text :content, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
