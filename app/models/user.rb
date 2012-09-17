class User
  include Mongoid::Document

  embeds_many :books

  has_many :authorizations, dependent: :destroy
  accepts_nested_attributes_for :authorizations

  field :name, type: String
  field :email, type: String

  before_validation :normalize_email

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def add_authorization(auth_params)
    new_auth = Authorization.build_from_authorization(auth_params)
    self.authorizations << new_auth
    new_auth
  end

  class << self
    def create_from_authorization(auth_params)
      email = auth_params['info']['email']
      user = User.where(email: email).first || User.new(email: email)
      user.name = auth_params['info']['name']
      user.authorizations << Authorization.build_from_authorization(auth_params)
      user.save!
      user
    end
  end

  protected
  def normalize_email
    self.email = email.strip.downcase if self.email
  end
end

