class Protocol < ApplicationRecord
	acts_as_taggable
	belongs_to :user
	has_many :protocol_favorites
end
