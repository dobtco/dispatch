class BaseUploader < CarrierWave::Uploader::Base
  self.aws_acl = :private

  def model_class_name
    model.class.to_s
  end

  def store_dir
    "uploads/#{store_digest}"
  end

  def store_digest
    Digest::SHA2.hexdigest(
      "#{model_class_name.underscore}-#{mounted_as}-#{model.id}"
    ).first(32)
  end

  def raw_filename
    @model.read_attribute(mounted_as)
  end

  def friendly_file_type
    if (ext = File.extname(raw_filename)).present?
      ext[1..-1].upcase # Remove '.' from string
    else
      '?'
    end
  end

  def download_url
    url(response_content_disposition: 'attachment')
  end
end
