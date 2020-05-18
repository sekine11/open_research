class LabMember < ApplicationRecord
	belongs_to :user
	belongs_to :laboratory

	enum status: { member: 0, subadmin: 1, admin: 2 }
end
