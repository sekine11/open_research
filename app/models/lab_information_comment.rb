class LabInformationComment < ApplicationRecord
	belongs_to :user
	belongs_to :lab_information
end
