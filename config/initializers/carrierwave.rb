CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_public = false
    config.fog_provider = 'fog/aws'
    config.fog_directory  = ENV['AWS_BUCKET']
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_REGION'],
    }
  else
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end

  CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end