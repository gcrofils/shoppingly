# Load Dragonfly if it isn't loaded already.
require "dragonfly"
require 'dragonfly/s3_data_store'

Dragonfly.app(:ckeditor).configure do
  plugin :imagemagick
  secret "48d13b0c4bcbeb4e119b04c2195cee53877865b7a87c847f44563ff22fd2202d"
  
  # Accept asset requests on /ckeditor_assets. Again, this path is
  # not mandatory. Just be sure to include :job somewhere.
  url_format "/media/:job/:basename.:format"

  if Rails.env.development? || Rails.env.test?
  # Store files in public/uploads/ckeditor. This is not
  # mandatory and the files don't even have to be stored under
  # public. See http://markevans.github.io/dragonfly/data-stores
  datastore :file,
    root_path: Rails.root.join("public", "uploads", "ckeditor", Rails.env).to_s,
    server_root: 'public'

  else
    datastore :s3,
      region: ENV['S3_BUCKET_REGION'],
      bucket_name: ENV['S3_BUCKET'],
      access_key_id: ENV['S3_KEY_ID'],
      secret_access_key: ENV['S3_SECRET_KEY'],
      url_host: 'demo-shoppingly.siz.yt',
      url_scheme: 'http'
  end
  
  
  
end

Rails.application.middleware.use Dragonfly::Middleware, :ckeditor
