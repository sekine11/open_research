class LabInformationComment < ApplicationRecord
  belongs_to :user
  belongs_to :lab_information

  validates :user_id, presence: true
  validates :lab_information_id, presence: true
  validates :content, presence: true
end
