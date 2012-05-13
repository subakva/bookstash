require 'dropbox_sdk'

class StorageService

  class Unauthorized < StandardError; end
  class NotFound < StandardError; end

  attr_reader :options

  def initialize(options = nil)
    options ||= {}
    @options = {
      app_name:         DROPBOX_APP_NAME,
      consumer_key:     DROPBOX_CONSUMER_KEY,
      consumer_secret:  DROPBOX_CONSUMER_SECRET,
      access_type:      DROPBOX_ACCESS_TYPE
    }.merge(options)

    @session = DropboxSession.new(@options[:consumer_key], @options[:consumer_secret])

    if @options[:access_key] && @options[:access_secret]
      @client = initialize_client(@options[:access_key], @options[:access_secret], @options[:access_type])
    end
  end

  def authorize(request_key = nil, request_secret = nil)
    if request_key && request_secret
      confirm_access(request_key, request_secret)
    else
      request_access
    end
  end

  # account_info: {"referral_link"=>"https://www.dropbox.com/referrals/NTE1NDMxOQ", "display_name"=>"Jason Wadsworth", "uid"=>15431, "country"=>"US", "quota_info"=>{"shared"=>88442659, "quota"=>2684354560, "normal"=>975815023}, "email"=>"jdwadsworth@gmail.com"}
  # upload: {
  #   "revision"      =>  1,
  #   "rev"           =>  "107acb476",
  #   "thumb_exists"  =>  false,
  #   "bytes"         =>  44940,
  #   "modified"      =>  "Sun, 13 May 2012 01:37:32 +0000",
  #   "client_mtime"  =>  "Sun, 13 May 2012 01:37:32 +0000",
  #   "path"          =>  "/mongodb.epub",
  #   "is_dir"        =>  false,
  #   "icon"          =>  "page_white",
  #   "root"          =>  "app_folder",
  #   "mime_type"     =>  "application/epub+zip",
  #   "size"          =>  "43.9 KB"
  # }
  # media: {"url"=>"https://dl.dropbox.com/0/view/zu9ym60v5qhinur/Apps/BookStash%20%281%29/mongodb.epub", "expires"=>"Sun, 13 May 2012 07:01:20 +0000"}

  # Q: Should the storage service be responsible for choosing the name? Different storage impls might
  # have different naming conventions or restrictions, so that does make some sense.
  def upload(path)
    ensure_authorization

    upload_name = File.basename(path)
    response = @client.put_file(upload_name, File.read(path))
    response.slice "path"
  end

  def media_url(path)
    fetch_url(path, :media)
  end

  def share_url(path)
    fetch_url(path, :shares)
  end

  protected

  # 
  # Raises DropboxError
  # Returns the url to access the file (authorization required)
  def fetch_url(path, method_name)
    ensure_authorization

    response = @client.send(method_name, path)
    response['url']
  rescue DropboxError => e
    if e.message =~ /Path .* not found/
      raise StorageService::NotFound.new(path)
    else
      # LOG HERE
      raise e
    end
  end

  # Checks that the session is authorized.
  # 
  # Raises StorageService::Unauthorized if the session is not authorized. 
  def ensure_authorization
    raise StorageService::Unauthorized.new unless @session.authorized?
  end

  # Initializes a client object for the given key and secret.
  # 
  # access_key - The access key for the account we want to access.
  # access_secret - The secret key for the account we want to access.
  # access_type - The 
  def initialize_client(access_key, access_secret, access_type = :app_folder)
    @session.set_access_token(access_key, access_secret)
    DropboxClient.new(@session, access_type)
  end

  def request_access
    request_token     = @session.get_request_token
    authorization_url = @session.get_authorize_url
    # LOG HERE
    {
      authorized:         false,
      request_key:        request_token.key,
      request_token:      request_token.secret,
      authorization_url:  authorization_url
    }
  end

  def confirm_access(request_key, request_secret)
    @session.set_request_token(request_key, request_secret)
    access_token = @session.get_access_token
    @client = initialize_client(access_token.key, access_token.secret)

    # LOG HERE
    {
      authorized:     true,
      access_key:     access_token.key,
      access_secret:  access_token.secret
    }
  rescue DropboxAuthError => e
    # LOG HERE
    request_access
  end
end
