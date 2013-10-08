CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: "AKIAJDO5R6IUYW5QUMNQ",
    aws_secret_access_key: "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"
  }
  config.fog_directory = "chris_blog"
end