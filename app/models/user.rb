class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # バリデーション
  validates :public_name, length: { in: 2..20 }
  validates :public_name, presence: true
  validates :private_name, length: { in: 2..20 }
  validates :private_name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  attachment :image, type: :image


  # アソシエーション
  has_many :questions, dependent: :destroy
  has_many :ques_favorites, dependent: :destroy
  has_many :favorite_questions, through: :ques_favorites, source: :question, dependent: :destroy
  has_many :ques_comments, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :discuss_favorites, dependent: :destroy
  has_many :favorite_discussions, through: :discuss_favorites, source: :discussion, dependent: :destroy
  has_many :discuss_comments, dependent: :destroy
  has_many :protocols, dependent: :destroy
  has_many :protocol_favorites, dependent: :destroy
  has_many :favorite_protocols, through: :protocol_favorites, source: :protocol, dependent: :destroy
  has_many :lab_members, dependent: :destroy
  has_many :laboratory, dependent: :destroy
  has_many :lab_tasks, dependent: :destroy
  has_many :lab_informations, dependent: :destroy
  has_many :lab_information_checks, dependent: :destroy
  has_many :lab_information_comments, dependent: :destroy
  has_many :events, dependent: :destroy

  def active_for_authentication?
    super && status == true
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
