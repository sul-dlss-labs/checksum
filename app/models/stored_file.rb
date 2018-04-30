# A wrapper around ActiveStorage::Blob that expects the local disk adapter
class StoredFile
  def self.create_from_upload(attachable)
    blob = ActiveStorage::Blob.create_after_upload!(
      io: attachable.open,
      filename: attachable.original_filename,
      content_type: attachable.content_type
    )
    new.with_blob(blob)
  end

  def self.find(key)
    new.with_blob(ActiveStorage::Blob.find_by!(key: key))
  end

  def with_blob(blob)
    @blob = blob
    self
  end

  def path
    ActiveStorage::Blob.service.send(:path_for, key)
  end

  def stored_md5
    @blob.checksum
  end

  delegate :key, to: :@blob
end
