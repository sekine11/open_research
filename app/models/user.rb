class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image

  # アソシエーション
  has_many :questions
  has_many :question_favorites
  has_many :question_comments
  has_many :discussions
  has_many :discuss_favorites
  has_many :discuss_comments
  has_many :protocols
  has_many :protocol_favorites
  has_many :lab_members
  has_many :lab_tasks
  has_many :lab_informations
  has_many :lab_informations_checks
  has_many :lab_informations_comments
  has_many :project_members
  has_many :project_tasks
  has_many :project_informations
  has_many :project_informations_checks
  has_many :project_informations_comments
end
