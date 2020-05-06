class Protocol < ApplicationRecord
	belongs_to :user
	has_many :protocol_favorites
end
