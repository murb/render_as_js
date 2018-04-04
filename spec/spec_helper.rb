require "bundler/setup"
require "date"
require "render_as_js"
require "action_view"
#
# class String
#   def html_safe
#     return self
#   end
# end
#
# def sanitize string
#   return string
# end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
