class Laboratory < ApplicationRecord
	has_many :lab_members
	has_many :lab_tasks
	has_many :lab_informations
	has_many :lab_informations_comments
	has_many :projects
	belongs_to :user
end
