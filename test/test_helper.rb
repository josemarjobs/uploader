require "bundler"

Bundler.require
Bundler.require :test

require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

def fixture_path file
  File.expand_path("../fixtures/#{file}", __FILE__)
end

def uploaded_file(file_path, mime_type, binary)
  Rack::Test::UploadedFile.new(file_path, mime_type, binary)
end

Sequel.connect "sqlite://db/db.sqlite3"


CarrierWave.configure do |config|
  config.root = File.expand_path "../../", __FILE__
  config.cache_dir = File.expand_path "../../public", __FILE__
end