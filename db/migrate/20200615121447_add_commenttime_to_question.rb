class AddCommenttimeToQuestion < ActiveRecord::Migration[5.2]
  def change
  	add_column :questions, :commented_at, :datetime, null: false, default: Time.now
  end
end
