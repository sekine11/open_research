class LabTask < ApplicationRecord
	belongs_to :user
	belongs_to :laboratory

	enum status: { incomplete: 0, progress: 1, complete: 2 }
end
