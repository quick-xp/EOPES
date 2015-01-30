class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def eve_online
    #raise request.env['omniauth.auth'].to_yaml
    @user = User.find_for_eve_online_oauth(request.env['omniauth.auth'])
    #id,name setting
    session[:user_id] = @user.uid
    session[:user_name] = @user.name

    if @user.persisted?
        sign_in_and_redirect @user, :event => :authentication
        set_flash_message(:notice, :success, :kind => "Eve Online") if is_navigational_format?
    end
  end
end