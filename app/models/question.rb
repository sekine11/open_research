class Question < ApplicationRecord
	acts_as_taggable_on :tags
	acts_as_taggable_on :questions
	belongs_to :user
	has_many :question_favorites
	has_many :question_comments
end
