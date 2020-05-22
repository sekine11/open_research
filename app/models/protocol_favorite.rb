class ProtocolFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :protocol

  validates :user_id, presence: true
  validates :protocol_id, presence: true
end
