require "test_helper"
require "uploaders/asset"
require "models/asset"
require "apps/v2"


describe "Upload a file" do
  include Rack::Test::Methods
  def app
    API::AppV2
  end
  describe "when authorized" do
    before do
      file_path = fixture_path "zip.zip"
      
      authorize "josemarjobs", "password"

      post "/v2/files", {
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

    it "retrieves the actual filename" do
      last_response.body.must_include "zip.zip"
    end

    it "retrieves the full path of the file" do
      last_response.body.must_include "public/uploads/assets"
    end

    it "references the user from the file" do
      last_response.body.must_include "josemarjobs"
    end
  end







  describe "when not authorized" do

    it "fails if no authentication is provided" do
      post "/v2/files"

      last_response.status.must_equal 401 # Unauthorized
    end
  end
end









