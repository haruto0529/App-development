class ImageUrlUploader < CarrierWave::Uploader::Base
  require 'streamio-ffmpeg'

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

  # 動画からサムネイル生成
  version :thumb do
    process :generate_video_thumbnail
  end

  def store_dir
    "uploads/post/image_url/#{model.id}"
  end

  def extension_allowlist
    %w(mp4 mov avi)
  end

  version :thumb do
    process :generate_video_thumbnail

    def full_filename(for_file = nil)
      "thumbnail.jpg"
    end
  end

  def generate_video_thumbnail
    cache_stored_file! unless cached?
    tmpfile = File.join(File.dirname(current_path), "tmp_video")

    File.rename(current_path, tmpfile)

    movie = FFMPEG::Movie.new(tmpfile)

    screenshot_path = current_path + ".jpg"
    movie.screenshot(screenshot_path, seek_time: 0, resolution: '320x240')

    File.rename(screenshot_path, current_path)
    file.instance_variable_set(:@content_type, "image/jpeg")

    File.delete(tmpfile) if File.exist?(tmpfile)
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
