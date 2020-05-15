class Protocol < ApplicationRecord
	acts_as_taggable 
	acts_as_taggable_on :protocols
	belongs_to :user
	has_many :protocol_favorites

	def favorited_by?(user)
        protocol_favorites.where(user_id: user.id).exists?
    end
end
