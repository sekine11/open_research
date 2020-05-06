class Question < ApplicationRecord
	acts_as_taggable
	belongs_to :user
	has_many :question_favorites
	has_many :question_comments
end
