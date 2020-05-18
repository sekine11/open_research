class Discussion < ApplicationRecord
	acts_as_taggable 
	acts_as_taggable_on :discussions
	belongs_to :user
	has_many :discuss_favorites
	has_many :discuss_comments

	validates :user_id, presence: true
	validates :subject, length: { in: 5..30 }
	validates :subject, presence: true
	validates :content, length: { in: 30..1000 }
	validates :content, presence: true

	enum status: { active: 0, inactive: 1 }

	def favorited_by?(user)
        discuss_favorites.where(user_id: user.id).exists?
    end
end
