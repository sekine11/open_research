class ProjectInformation < ApplicationRecord
	belongs_to :user
	belongs_to :project
	has_many :project_informations_checks
	has_many :project_informations_comments
end
