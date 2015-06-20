require 'spec_helper'

module IntegrateMacros
  def hello
    puts "hello world"
  end

  def dummy_omniauth_login
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:eve_online] =
        OmniAuth::AuthHash.new({
                                   :provider => 'eve_online',
                                   :uid => '123456789',
                                   :name => 'Integration Test'
                                   # etc.
                               })

    OmniAuth.config.add_mock(:eve_online, {:uid => '123456789'})
  end

end