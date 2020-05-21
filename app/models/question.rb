class Question < ApplicationRecord
	acts_as_taggable 
	acts_as_taggable_on :questions
	belongs_to :user
	has_many :ques_favorites, dependent: :destroy
	has_many :ques_comments, dependent: :destroy

	validates :question_list, presence: true
	validates :user_id, presence: true
	validates :subject, length: { in: 5..50 }
	validates :subject, presence: true
	validates :content, length: { in: 30..2000 }
	validates :content, presence: true

	enum status: { accepting: 0, completed: 1 }

	is_impressionable :counter_cache => true, :unique => [:session_hash]

	def favorited_by?(user)
        ques_favorites.where(user_id: user.id).exists?
    end
end
