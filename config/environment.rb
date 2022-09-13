# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

config.gem 'carrierwave', :version => '~> 2.0'
config.gem 'cloudinary'
