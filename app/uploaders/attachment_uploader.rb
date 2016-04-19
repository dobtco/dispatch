class AttachmentUploader < BaseUploader
  include CarrierWave::MiniMagick

  process :save_content_type_and_size_in_model

  version :thumb, if: :thumbable? do
    process :make_thumbnail

    # Ensure that thumbs are saved as pngs rather than the original format
    def full_filename(*args)
      filename = super(*args)
      File.basename(filename, File.extname(filename)) + '.png'
    end
  end

  protected

  def thumbable?(file)
    content_type = file.try(:content_type) || model.try(:content_type)
    content_type && content_type.match(/image|pdf/)
  end

  def make_thumbnail
    manipulate! do |image|
      image.format('png', 0) { |c| c.thumbnail('256x256') }

      # Remove transparency from PDFs
      if content_type['pdf']
        image.background 'white'
        image.alpha 'remove'
      else
        image
      end
    end

    model.has_thumbnail = true

    # See https://github.com/carrierwaveuploader/carrierwave/issues/617
    self.file.instance_variable_set(:@content_type, 'image/png')

  # Using exceptions for control flow is hacky, this could be refactored:
  # see https://github.com/dobtco/screendoor-v2/commit/8691546fea20fbae0929a0564784bef8c9180aad
  rescue CarrierWave::ProcessingError => e
    Rails.logger.warn(
      "[AttachmentUploader] Error generating thumbnail: #{e.message}"
    )
  end

  def save_content_type_and_size_in_model
    model.content_type = file.try(:content_type)
    model.file_size_bytes = file.try(:size)
  end
end
