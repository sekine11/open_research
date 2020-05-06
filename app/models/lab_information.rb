class LabInformation < ApplicationRecord
	belongs_to :user
	belongs_to :laboratory
	has_many :lab_informations_checks
	has_many :lab_informations_comments
end
