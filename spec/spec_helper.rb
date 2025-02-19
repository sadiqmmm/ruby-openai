require "bundler/setup"
require "ruby/openai"
require "vcr"

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.default_cassette_options = { record: :new_episodes }
  c.filter_sensitive_data("<OPENAI_ACCESS_TOKEN>") { ENV.fetch("OPENAI_ACCESS_TOKEN") }
  c.filter_sensitive_data("<OPENAI_ORGANIZATION_ID>") { ENV.fetch("OPENAI_ORGANIZATION_ID", nil) }
end

RSpec.configure do |c|
  # Enable flags like --only-failures and --next-failure
  c.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  c.disable_monkey_patching!

  c.expect_with :rspec do |rspec|
    rspec.syntax = :expect
  end
end

RSPEC_ROOT = File.dirname __FILE__
