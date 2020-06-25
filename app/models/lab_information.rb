class LabInformation < ApplicationRecord
  belongs_to :user
  belongs_to :laboratory
  has_many :lab_information_checks, dependent: :destroy
  has_many :lab_information_comments, dependent: :destroy

  has_many :information_documents, dependent: :destroy
  accepts_attachments_for :information_documents, attachment: :document

  validates :user_id, presence: true
  validates :laboratory_id, presence: true
  validates :subject, length: { in: 2..50 }
  validates :subject, presence: true
  validates :content, length: { in: 30..2000 }
  validates :content, presence: true

  def checked_by?(user)
    lab_information_checks.where(user_id: user.id).exists?
  end

end
