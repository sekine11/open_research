class LabInformation < ApplicationRecord
  belongs_to :user
  belongs_to :laboratory
  has_many :lab_information_checks, dependent: :destroy
  has_many :lab_information_comments, dependent: :destroy

  attachment :document, extension: "pdf"

  validates :user_id, presence: true
  validates :laboratory_id, presence: true
  validates :subject, length: { in: 2..50 }
  validates :subject, presence: true
  validates :content, length: { in: 30..2000 }
  validates :content, presence: true

  def checked_by?(user)
    lab_information_checks.where(user_id: user.id).exists?
  end

  def file_extension
    document_content_type.split("/").last.to_sym
  end
end
