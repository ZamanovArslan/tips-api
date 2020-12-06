require "shrine"
require "shrine/storage/file_system"
require "shrine/storage/s3"
require "shrine/storage/memory"

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :determine_mime_type
Shrine.plugin :remove_attachment
Shrine.plugin :restore_cached_data
Shrine.plugin :validation
Shrine.plugin :validation_helpers

def s3_options
  {
    access_key_id: Rails.application.credentials.aws[:access_key_id],
    secret_access_key: Rails.application.credentials.aws[:secret_access_key],
    region: Rails.application.credentials.aws[:region],
    bucket: Rails.application.credentials.aws[:bucket]
  }
end

def amazon_s3_storages
  {
    cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
    store: Shrine::Storage::S3.new(prefix: "store", upload_options: { acl: "public-read" }, **s3_options)
  }
end

def memory_storages
  {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
end

def filesystem_storages
  {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "/uploads/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "/uploads")
  }
end

def local_storages
  Rails.env.test? ? memory_storages : filesystem_storages
end

Shrine.storages = s3_options.values.all? ? amazon_s3_storages : local_storages
