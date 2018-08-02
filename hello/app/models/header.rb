module Header
  extend ActiveSupport::Concern

  def default_header json = nil
    header = {}
    header.merge! :basic_auth => auth
    header.merge! :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
    header.merge! :body => json.to_json if json

    header
  end

  def upload_header
    { 
      :Authorization => upload_auth,
      :content_type => :json, 
      :accept => :json
    }
  end

  def auth
    {:username => "cf09d542-a995-45b1-a203-4f8e191380bf", :password => "3668bfb72795355d4e652c831e299485"}
  end

  def upload_auth
    auth = Base64.strict_encode64 "cf09d542-a995-45b1-a203-4f8e191380bf:3668bfb72795355d4e652c831e299485"
    "Basic #{auth}"
  end

  def base_url path, options = {}
    url = "#{base}/#{path}"
    url = "#{url}?#{options.to_param}" unless options.empty?
    url
  end

  private
  def base
    "http://localhost:3000/v1"
  end
end
