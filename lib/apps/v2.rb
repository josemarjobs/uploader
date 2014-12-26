module API
  class AppV2 < Grape::API
    version :v2, using: :path # /v2/*

    use Rack::Config do |env|
      env['api.tilt.root'] = File.join(Dir.pwd, "lib/views")
    end

    default_format :json
    formatter :json, Grape::Formatter::Rabl

    http_basic do |handler, password|
      @@user = User.where(handler: handler).first
      @@user.authorized? password
    end

    resource :files do
      get '/', rabl: 'assets/collection' do
        @assets = Asset.all
      end
      post '/', rabl: 'assets/item' do
        params[:file][:user_id] = @@user.id
        @asset = Asset.new params[:file]
        @asset.save
      end

    end

    resource :users do
      post "/", rabl: "users/item" do
        @user = User.new(params[:user])
        @user.save
      end

    end

  end

end