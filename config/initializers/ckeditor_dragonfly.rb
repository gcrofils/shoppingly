# Load Dragonfly if it isn't loaded already.
require "dragonfly"

Dragonfly.app(:ckeditor).configure do
  plugin :imagemagick
  secret "48d13b0c4bcbeb4e119b04c2195cee53877865b7a87c847f44563ff22fd2202d"

  # Store files in public/uploads/ckeditor. This is not
  # mandatory and the files don't even have to be stored under
  # public. See http://markevans.github.io/dragonfly/data-stores
  datastore :file,
    root_path: Rails.root.join("public", "uploads", "ckeditor", Rails.env).to_s,
    server_root: 'public'

  # Accept asset requests on /ckeditor_assets. Again, this path is
  # not mandatory. Just be sure to include :job somewhere.
  url_format "/uploads/ckeditor/:job/:basename.:format"
end

Rails.application.middleware.use Dragonfly::Middleware, :ckeditor
