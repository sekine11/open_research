class ProjectInformationComment < ApplicationRecord
	belongs_to :user
	belongs_to :project_information
end