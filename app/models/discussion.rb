class Discussion < ApplicationRecord
	acts_as_taggable_on :tags
	acts_as_taggable_on :discussions
	belongs_to :user
	has_many :discuss_favorites
	has_many :discuss_comments
end
