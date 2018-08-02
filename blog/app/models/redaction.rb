class Redaction
  # concerns
  include Mongoid::Document
  include Mongoid::Timestamps
  include Buildable

  # fields
  field :subject, type: String
  field :body, type: String
  field :permalink, type: String
  field :tags, type: Array
  
  # relations
  belongs_to :author
  embeds_many :comments

  # indexes
  index({ permalink: 1 }, { unique: true, name: "permalink_index" })

  # validations
  validates :subject, :body, :author, :permalink, presence: true
  validates_uniqueness_of :permalink


  def self.build params = {}
    redaction = super(params)
    redaction.permalink = redaction.subject.parameterize
    redaction.save
    redaction
  end
end