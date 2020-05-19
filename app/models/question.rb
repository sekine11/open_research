class Question < ApplicationRecord
	acts_as_taggable 
	acts_as_taggable_on :questions
	belongs_to :user
	has_many :ques_favorites
	has_many :ques_comments

	validates :user_id, presence: true
	validates :subject, length: { in: 5..30 }
	validates :subject, presence: true
	validates :content, length: { in: 30..1000 }
	validates :content, presence: true

	enum status: { accepting: 0, completed: 1 }

	is_impressionable :counter_cache => true, :unique => [:impressionable_id, :session_hash]

	def favorited_by?(user)
        ques_favorites.where(user_id: user.id).exists?
    end
end
