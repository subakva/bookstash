class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  # embeds_many :book_versions

  field :title, type: String
  validates_presence_of :title
end
