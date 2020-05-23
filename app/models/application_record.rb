class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def create_time
    created_at.strftime("%Y/%m/%d %H:%M")
  end

  def update_time
    updated_at.strftime("%Y/%m/%d %H:%M")
  end
end
