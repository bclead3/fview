# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

Utils::Loader.new


RAILS_ROOT = Rails.root