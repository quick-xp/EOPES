require 'rails_helper'
require File.expand_path("../support/integrate_macros.rb", __FILE__)
Dir.glob("spec/**/*steps.rb") { |f| load f, true }

RSpec.configure do |config|
  config.include IntegrateMacros, :type => :request
  puts "hello world2"
  config.before(:type => feature) do
    #dummy_omniauth_login
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:eve_online] =
        OmniAuth::AuthHash.new({
                                   :provider => 'eve_online2',
                                   :uid => '123456789'
                                   # etc.
                               })

    OmniAuth.config.add_mock(:eve_online, {:uid => '123456789'})

    #@request.env["devise.mapping"] = Devise.mappings[:user]
    #@request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:eve_online]
    puts "hello world "
  end
end

