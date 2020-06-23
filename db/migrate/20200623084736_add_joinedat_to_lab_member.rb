class AddJoinedatToLabMember < ActiveRecord::Migration[5.2]
  def change
  	add_column :lab_members, :joined_at, :datetime
  end
end