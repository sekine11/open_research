class CreateProtocols < ActiveRecord::Migration[5.2]
  def change
    create_table :protocols do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subject, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
