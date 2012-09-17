class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user

  field :title, type: String
  validates_presence_of :title
end
