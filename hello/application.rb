require File.expand_path('../environment', __FILE__)

module API
end

require 'action_controller/metal/strong_parameters'
require 'exceptions'
# require 'app/helpers/route_helpers'
# require 'app/doc/sample_requests'
# require 'app/api/base'
# require 'app/representers/base_representer'
# require 'newrelic-grape'

Dir["#{File.dirname(__FILE__)}/app/**/*.rb"].each {|f| require f}

# ActiveRecord::Base.instance_eval do
#   include ActiveModel::MassAssignmentSecurity
#   attr_accessible []
# end


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

  mount API::Hello
  mount API::KanaTest
end

# SprocketsApp = Sprockets::Environment.new
# SprocketsApp.append_path "app/javascripts"

ApplicationServer = Rack::Builder.new do
  if ['production', 'staging'].include? Application.config.env
    # use Rack::SslEnforcer
  end

  use Rack::Static, urls: %w{/css /images}, :root => "public", index: 'index.html'

  # map "/javascripts" do
  #   run SprocketsApp
  # end

  map "/" do
    run API::Root
  end
end
