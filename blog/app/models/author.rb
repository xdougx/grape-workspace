class Author
  include Mongoid::Document
  include Mongoid::Timestamps
  include Buildable

  # fields
  field :name, type: String
  field :email, type: String
  field :small_description, type: String

  # relations
  has_many :redactions

  # validations
  validates :name, :email, :small_description, presence: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :email

end