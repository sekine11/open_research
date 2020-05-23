class Contact < ApplicationRecord
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :title, presence: true, length: { in: 1..30 }
  validates :message, presence: true
end
