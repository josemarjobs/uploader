require "test_helper"
require "uploaders/asset"
require "models/asset"
require "apps/v2public"

describe "Downloading the file as another user" do
  include Rack::Test::Methods

  def app
    API::AppV2Public  
  end

  let(:id) { 10 }
  let(:path) { "/v2/files/#{id}/download" }
  it "downloads a file as another user" do
    get path, receiver: "person@example.com"

    last_response.status.must_equal 302
  end

  it "fails to download the files as the incorrect user" do
    get path, receiver: "nobody@example.com"

    last_response.status.must_equal 403
  end
end