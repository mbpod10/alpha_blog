# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Get rid of error div after validation messages show up
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end