class CreateInformationDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :information_documents do |t|
      t.references :lab_information, null: false, foreign_key: true
      t.string :document_id, null: false
      t.string :document_filename, null: false
      t.string :document_size, null: false
      t.string :document_content_type, null: false

      t.timestamps
    end
  end
end
