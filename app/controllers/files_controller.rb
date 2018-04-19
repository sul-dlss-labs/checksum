# frozen_string_literal: true

# Supports upload of file.
class FilesController < ApplicationController
  # Upload a new file by doing:
  #   curl -Ffile=@README.md localhost:3000/files
  #
  # On success it will return a 201 status with the file's
  # key.
  def create
    attachable = params[:file]
    file = StoredFile.create_from_upload(attachable)
    render json: { id: file.key }, status: :created
  end
end
