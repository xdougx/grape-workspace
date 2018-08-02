$path = "#{File.expand_path(".")}/app"
require File.expand_path('../environment', __FILE__)

module API
end

require 'action_controller/metal/strong_parameters'
require 'actionpack/lib/abstract_controller/rendering.rb'
require 'exceptions'
# require 'newrelic-grape'

Dir["#{$path}/api/**/**"].each {|f| require f}
Dir["#{$path}/models/concerns/**/*.rb"].each {|f| require f}
Dir["#{$path}/models/**/*.rb"].each {|f| require f}

class API::Root < Grape::API
  content_type :html, 'text/html'
  content_type :json, 'application/json'
  format :html
  format :json

  before do
    header['Access-Control-Allow-Origin'] = '*'
    header['Access-Control-Request-Method'] = '*'
  end

  rescue_from :all do |exception|
    ap exception.backtrace
    ap exception.error
    Rack::Response.new(exception.error.to_json, exception.status, { "Content-type" => "application/json" }).finish
  end

  mount API::Blog
end

SprocketsApp = Sprockets::Environment.new
SprocketsApp.append_path "app/assets/js"

ApplicationServer = Rack::Builder.new do
  if ['production', 'staging'].include? Application.config.env
    # use Rack::SslEnforcer
  end

  use Rack::Static, urls: %w{/css /images}, :root => "public", index: 'index.html'

  map "/javascripts" do
    run SprocketsApp
  end

  map "/" do
    run API::Root
  end
end
