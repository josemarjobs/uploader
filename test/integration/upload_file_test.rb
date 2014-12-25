require "test_helper"
require "uploaders/asset"
require "models/asset"
require "app"


describe "Upload a file" do
  include Rack::Test::Methods
  def app
    API::App
  end
  
  before do
    file_path = fixture_path "zip.zip"
    post "/files", {
      file: {
        title: "My first Zip file",
        file: uploaded_file(file_path, "application/zip", true)
      }
    }
  end

  it "uploads a file" do
    last_response.status.must_equal 201
  end

  it "retrieves the content for the new file" do
    last_response.body.must_include "My first Zip file"
  end

  it "retries the actual filename" do
    last_response.body.must_include "zip.zip"
  end

end