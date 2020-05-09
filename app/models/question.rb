class Question < ApplicationRecord
	acts_as_taggable 
	acts_as_taggable_on :questions
	belongs_to :user
	has_many :ques_favorites
	has_many :ques_comments

	enum status: { accepting: 0, completed: 1 }

	def favorited_by?(user)
        ques_favorites.where(user_id: user.id).exists?
    end
end
