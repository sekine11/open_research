class Question < ApplicationRecord
	belongs_to :user
	has_many :question_favorites
	has_many :question_comments
end
