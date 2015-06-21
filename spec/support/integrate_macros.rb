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

  def get_crest_market_url(region_id, type_id, market_kind = "sell")
    url = "https://crest-tq.eveonline.com/market/" +
        region_id.to_s +
        "/orders/"+ market_kind.downcase + "/?type=https://crest-tq.eveonline.com/types/" +
        type_id.to_s +
        "/"
    return url
  end

end