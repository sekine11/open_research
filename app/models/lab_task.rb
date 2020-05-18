class LabTask < ApplicationRecord
	belongs_to :user
	belongs_to :laboratory

	validates :user_id, presence: true
	validates :laboratory_id, presence: true
	validates :content, length: { in: 1..20 }
	validates :content, presence: true

	enum status: { incomplete: 0, progress: 1, complete: 2 }
end
