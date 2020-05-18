class LabInformation < ApplicationRecord
	belongs_to :user
	belongs_to :laboratory
	has_many :lab_information_checks
	has_many :lab_information_comments

	validates :user_id, presence: true
	validates :laboratory_id, presence: true
	validates :subject, length: { in: 5..30 }
	validates :subject, presence: true
	validates :content, length: { in: 30..1000 }
	validates :content, presence: true

	def checked_by?(user)
        lab_information_checks.where(user_id: user.id).exists?
    end
end
