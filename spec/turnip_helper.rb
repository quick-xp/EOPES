require 'rails_helper'
require File.expand_path("../support/integrate_macros.rb", __FILE__)
require 'net/http'
Dir.glob("spec/**/*steps.rb") { |f| load f, true }

RSpec.configure do |config|
  @test_step_no = 0
  #WebMock.allow_net_connect!
  #重要
  WebMock.disable_net_connect!(:allow_localhost => true)

  config.include IntegrateMacros
  config.before(:type => :feature) do
    #dummy_omniauth_login
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:eve_online] =
        OmniAuth::AuthHash.new({
                                   :provider => 'eve_online2',
                                   :uid => '123456789',
                                   :credentials => {token: 'dummy_token',
                                                    expires_at: Time.current.to_i + 60 * 60 * 24, #1 day add
                                                    refresh_token: "dummy"},
                                   info: {character_name: 'Integration Test'}
                                   # etc.
                               })

  end

end

