class Protocol < ApplicationRecord
  acts_as_taggable
  acts_as_taggable_on :protocols
  belongs_to :user
  has_many :protocol_favorites, dependent: :destroy

  validates :protocol_list, presence: true
  validates :user_id, presence: true
  validates :subject, length: { in: 5..50 }
  validates :subject, presence: true
  validates :content, length: { in: 30..5000 }
  validates :content, presence: true

  is_impressionable :counter_cache => true, :unique => [:session_hash]

  def favorited_by?(user)
    protocol_favorites.where(user_id: user.id).exists?
  end
end
