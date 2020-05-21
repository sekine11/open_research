class Discussion < ApplicationRecord
	acts_as_taggable 
	acts_as_taggable_on :discussions
	belongs_to :user
	has_many :discuss_favorites, dependent: :destroy
	has_many :discuss_comments, dependent: :destroy

	validates :discussion_list, presence: true
	validates :user_id, presence: true
	validates :subject, length: { in: 5..30 }
	validates :subject, presence: true
	validates :content, length: { in: 30..1000 }
	validates :content, presence: true

	enum status: { active: 0, inactive: 1 }

	is_impressionable :counter_cache => true, :unique => [:session_hash]

	def favorited_by?(user)
        discuss_favorites.where(user_id: user.id).exists?
    end
end
