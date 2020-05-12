class LabInformation < ApplicationRecord
	belongs_to :user
	belongs_to :laboratory
	has_many :lab_information_checks
	has_many :lab_information_comments

	def checked_by?(user)
        lab_information_checks.where(user_id: user.id).exists?
    end
end
