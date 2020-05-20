class AddPdfIdToLabInformations < ActiveRecord::Migration[5.2]
  def change
    add_column :lab_informations, :document_id, :string
    add_column :lab_informations, :document_filename, :string
    add_column :lab_informations, :document_size, :string
    add_column :lab_informations, :document_content_type, :string
  end
end
