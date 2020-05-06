class CreateQuesComments < ActiveRecord::Migration[5.2]
  def change
    create_table :ques_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.string :comment, null: false

      t.timestamps
    end
  end
end
