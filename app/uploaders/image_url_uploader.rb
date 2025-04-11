class ImageUrlUploader < CarrierWave::Uploader::Base

  # Include RMagick, MiniMagick, or Vips support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # include CarrierWave::Vips

  # Choose what kind of storage to use for this uploader:
  # developmentとtest以外はS3を使用

  if Rails.env.development? || Rails.env.test?
    storage :file
  else
    storage :fog
  end

  def store_dir
    "uploads/post/image_url/#{model.id}"
  end

  def content_type_allowlist
    ['video/mp4', 'video/quicktime', 'video/x-msvideo']
  end

  def filename
    if original_filename.present?
      timestamp = Time.now.to_i
      ext = File.extname(original_filename)
      "video_#{timestamp}#{ext}"
    else
      # original_filenameがnilや空の場合、デフォルトのファイル名を返す
      "default_video.mp4"
    end
  end


  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_allowlist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg"
  # end
end
