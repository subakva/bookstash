module DropboxAccess
  extend ActiveSupport::Concern
  include Mongoid::Document

  included do
    # field :dropbox_request_key, type: String
    # field :dropbox_request_secret, type: String
    # validates_presence_of :dropbox_request_secret, if: proc { |da| da.dropbox_request_key.present? }

    # field :dropbox_access_key, type: String
    # field :dropbox_access_secret, type: String
    # validates_presence_of :dropbox_access_secret, if: proc { |da| da.dropbox_access_key.present? }

    # TODO: Encrypt the secrets in the database, using a key that is NOT stored in the database
    # before_save :encrypt_secrets
  end

  module ClassMethods
  end
end
