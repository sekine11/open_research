class ProjectInformation < ApplicationRecord
	belongs_to :user
	belongs_to :project
	has_many :project_information_checks
	has_many :project_information_comments
end
