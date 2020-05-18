class Laboratory < ApplicationRecord
	has_many :lab_members
	has_many :lab_tasks
	has_many :lab_informations
	has_many :events
	belongs_to :user

	validates :user_id, presence: true
	validates :name, length: { in: 5..30 }
	validates :name, presence: true
end
