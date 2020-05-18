class LabMember < ApplicationRecord
	belongs_to :user
	belongs_to :laboratory

	validates :user_id, presence: true
	validates :laboratory_id, presence: true

	enum status: { member: 0, subadmin: 1, admin: 2 }
end
