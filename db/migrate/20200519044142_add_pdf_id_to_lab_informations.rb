class AddPdfIdToLabInformations < ActiveRecord::Migration[5.2]
  def change
    add_column :lab_informations, :pdf_id, :string
  end
end
