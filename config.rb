require 'extensions/sprite_factory'

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

ignore 'images/sprites/icons/*'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_path, "/Content/images/"

  # Minify HTML
  activate :minify_html

  activate :gzip
end

# custom extensions
activate :sprite_factory

# Enable cache buster
activate :asset_hash

activate :sync do |sync|
  sync.fog_provider = 'AWS' # Your storage provider
  sync.fog_directory = 'www.iainbeeston.com' # Your bucket name
  sync.fog_region = 'us-east-1' # The region your storage bucket is in
  sync.aws_access_key_id = 'AKIAJ7ZFT4UXEW3JMAMQ' # Your Amazon S3 access key
  sync.aws_secret_access_key = ENV['AWS_SECRET_KEY'] # Your Amazon S3 access secret
  sync.aws_reduced_redundancy = true # Use reduced redundnacy storage
  sync.existing_remote_files = 'delete' # What to do with your existing remotefiles?
  sync.after_build = false # Disable sync to run after Middleman build
end
