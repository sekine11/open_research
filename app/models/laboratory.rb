class Laboratory < ApplicationRecord
  has_many :lab_members, dependent: :destroy
  has_many :lab_tasks, dependent: :destroy
  has_many :lab_informations, dependent: :destroy
  has_many :events, dependent: :destroy
  belongs_to :user

  validates :user_id, presence: true
  validates :name, length: { in: 5..30 }
  validates :name, presence: true
end
