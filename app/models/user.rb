class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # バリデーション
  validates :public_name, length: { in: 2..20 }
  validates :public_name, presence: true
  validates :private_name, length: { in: 2..20 }
  validates :private_name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image, type: :image


  # アソシエーション
  has_many :questions
  has_many :ques_favorites
  has_many :ques_comments
  has_many :discussions
  has_many :discuss_favorites
  has_many :discuss_comments
  has_many :protocols
  has_many :protocol_favorites
  has_many :lab_members
  has_many :laboratory
  has_many :lab_tasks
  has_many :lab_informations
  has_many :lab_information_checks
  has_many :lab_information_comments
  has_many :events

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
