class Project < ApplicationRecord
	belongs_to :laboratory
	has_many :project_members
	has_many :project_tasks
	has_many :project_informations
end
