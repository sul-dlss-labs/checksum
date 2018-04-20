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
    render json: { id: file.key, md5: file.stored_md5 }, status: :created
  end

  # Returns json indicating whether the file on disk has the correct checksum
  #    curl localhost:3000/files/Unes6vWukx3xhZhQf51Gv8vh/validate
  def validate
    file = StoredFile.find(params[:id])
    digest = Digest::MD5.file(file.path).base64digest
    if file.stored_md5 == digest
      render json: { status: 'valid' }
    else
      render json: { status: 'invalid',
                     actual: digest,
                     expected: file.stored_md5,
                      path: file.path }
    end
  end
end
