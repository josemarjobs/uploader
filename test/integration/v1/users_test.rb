require 'test_helper'
require 'models/user'
describe "User" do
  include Rack::Test::Methods

  def app
    API::App
  end

  describe "signing up" do
      before do
        post "/users", user: {
          handler: "josemarjobs",
          name: "Josemar Magalhaes",
          password: "password"
        }
      end
      
      it "can create the user" do
        last_response.status.must_equal 201
      end

      it "shows the handler" do
        last_response.body.must_include  "josemarjobs"
      end
      it "shows the name" do
        last_response.body.must_include  "Josemar Magalhaes"
      end
  end
end