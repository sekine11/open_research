class Event < ApplicationRecord
	belongs_to :user
	belongs_to :laboratory

	validates :user_id, presence: true
	validates :laboratory_id, presence: true
	validates :title, length: { in: 1..20 }
	validates :title, presence: true
	validates :start, presence: true
	validates :end, presence: true
end
