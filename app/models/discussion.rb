class Discussion < ApplicationRecord
	acts_as_taggable
	belongs_to :user
	has_many :discuss_favorites
	has_many :discuss_comments
end
