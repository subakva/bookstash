class Authorization
  include Mongoid::Document

  belongs_to :user

  field :provider, type: String
  field :uid, type: String

  validates :provider, :uid, presence: true
  validates_uniqueness_of :uid, scope: :provider

  class << self
    def build_from_authorization(auth_hash)
      Authorization.new(
        provider: auth_hash['provider'],
        uid: auth_hash['uid']
      )
    end

    def find_by_authorization(auth_hash)
      Authorization.where(
        provider: auth_hash["provider"],
        uid: auth_hash["uid"]
      ).first
    end
  end
end
