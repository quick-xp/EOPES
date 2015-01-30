class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def eve_online
    raise request.env['omniauth.auth'].to_yaml
  end
end