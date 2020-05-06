class CreateDiscussComments < ActiveRecord::Migration[5.2]
  def change
    create_table :discuss_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :discussion, null: false, foreign_key: true
      t.string :content, null: false

      t.timestamps
    end
  end
end
