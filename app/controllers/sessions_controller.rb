class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']

    if self.current_user
      Rails.logger.debug "** Already logged in: #{self.current_user.email}"
      self.current_user.add_authorization(auth_hash)
      redirect_to root_url
    else
      @authorization = Authorization.find_by_authorization(auth_hash)
      if @authorization
        self.current_user = @authorization.user
        Rails.logger.debug "** Found authorization: #{self.current_user.email}"
        redirect_to root_url
      else
        self.current_user = User.create_from_authorization(auth_hash)
        Rails.logger.debug "** Created user: #{self.current_user.email}"
        redirect_to root_url
      end
    end
  end

  def failure
  end

  def destroy
    self.current_user = nil
    redirect_to root_url
  end
end
