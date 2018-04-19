# frozen_string_literal: true

# Supports upload of file.
class FilesController < ApplicationController
  # Upload a new file by doing:
  #   curl -Ffile=@README.md localhost:3000/files
  #
  # On success it will return a 204 status with a Location header
  # pointing at the download path.
  def create
    attachable = params[:file]
    blob = ActiveStorage::Blob.create_after_upload!(
      io: attachable.open,
      filename: attachable.original_filename,
      content_type: attachable.content_type
    )
    head :no_content, location: blob
  end
end
