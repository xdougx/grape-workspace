require File.expand_path('../header', __FILE__)

class Document
  include HTTParty
  include Header

  def self.create params
    RestClient.post(new.base_url("document_versions"), params, new.upload_header) do |resource, request, result|
      resource = JSON.parse resource

      # if valid_response?(resource)
      #   build(resource)
      # else
      #   raise Exceptions::Resource.build(resource["error"])
      # end
    end
  end

end