require 'exceptions'
class Redaction
  include Mongoid::Document

  field :subject, type: String
  field :body, type: String
  field :owner_name, type: String

  validates :subject, :body, :owner_name, presence: true

  class << self
    def build params = {}
      redaction = new params

      if redaction.valid?
        redaction.save
        redaction
      else
        raise Exceptions::Model.build(redaction)
      end
    end
  end
end