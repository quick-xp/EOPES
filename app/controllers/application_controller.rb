class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to welcome_index_path unless user_signed_in?
  end

  def get_token
    #create access token
    client = OAuth2::Client.new(ENV['EVE_ONLINE_APP_ID'], ENV['EVE_ONLINE_APP_SECRET'])
    if token_expired?
      refresh_token
    end
    token = session[:access_token]
    OAuth2::AccessToken.new(client, token)
  end

  def refresh_token
    response = RestClient.post "https://login.eveonline.com/oauth/token",
                               :grant_type => 'refresh_token',
                               :refresh_token => session[:refresh_token],
                               :client_id => session[:client_id],
                               :client_secret => session[:client_secret]

    refresh_hash = JSON.parse(response.body)
    session[:access_token] = refresh_hash[:access_token]
    session[:expires_at] = DateTime.current.to_i + refresh_hash["expires_in"].to_i
    session[:refresh_token] = refresh_hash[:refresh_token]
  end

  def token_expired?
    expires_at = session[:expires_at]
    current_time = Time.current.to_i
    if expires_at < current_time
      return true
    end
    false
  end
end
