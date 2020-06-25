class InformationDocument < ApplicationRecord
	belongs_to :lab_information
	attachment :document, extension: ["pdf", "doc", "docx", "pptx", "xlsx", "csv", "jpg", "png", "tiff"]

	def file_extension
      require 'rack/mime'
      Rack::Mime::MIME_TYPES.invert[document_content_type].split('.').last
    end
end
