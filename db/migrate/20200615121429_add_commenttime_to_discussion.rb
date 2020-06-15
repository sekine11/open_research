class AddCommenttimeToDiscussion < ActiveRecord::Migration[5.2]
  def change
  	add_column :discussions, :commented_at, :datetime, null: false, default: Time.now
  end
end
