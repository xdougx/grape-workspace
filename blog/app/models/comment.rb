class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  include 

  field :name, type: String
  field :email, type: String
  field :body, type: String
  field :status, type: String

  embedded_in :redaction

  validates :name, :email, :body, presence: true 

  def aprove!
    self.status = 'aproved'
    self.save!
  end

  class << self
    def build params = {}
      comment = new params

      if comment.valid?
        comment.save
        comment
      else
        raise Exceptions::Model.build(comment)
      end
    end
  end


end