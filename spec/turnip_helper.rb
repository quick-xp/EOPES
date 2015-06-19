require 'rails_helper'
require File.expand_path("../support/integrate_macros.rb", __FILE__)
Dir.glob("spec/**/*steps.rb") { |f| load f, true }

RSpec.configure do |config|
  config.include IntegrateMacros, :type => :request

  config.before(:type => feature) do
    #dummy_omniauth_login
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:eve_online] =
        OmniAuth::AuthHash.new({
                                   :provider => 'eve_online',
                                   :uid => '123456789'
                                   # etc.
                               })

    OmniAuth.config.add_mock(:eve_online, {:uid => '123456789'})
  end
end

