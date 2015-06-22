# encoding: utf-8
require 'rails_helper'
require 'spec_helper'
# Dummy crest
step 'テストのためダミーマーケットデータを使用するようにする' do
  #WebMock.stub_request(:any, "http://localhost:3011/home").to_return(status: 404,:body => "hello")
  #puts Net::HTTP.get(URI.parse("http://localhost:3011/home"))

  WebMock.stub_request(:any, get_crest_market_url(10000002, 34, "sell"))
      .to_return(:body => json_response("the_forge_item_34.json"))

  WebMock.stub_request(:any, get_crest_market_url(10000002, 35, "sell"))
      .to_return(:body => json_response("the_forge_item_34.json"))

  WebMock.stub_request(:any, get_crest_market_url(10000002, 36, "sell"))
      .to_return(:body => json_response("the_forge_item_34.json"))

  WebMock.stub_request(:any, get_crest_market_url(10000002, 37, "sell"))
      .to_return(:body => json_response("the_forge_item_34.json"))

  WebMock.stub_request(:any, get_crest_market_url(10000002, 238, "sell"))
      .to_return(:body => json_response("the_forge_item_34.json"))
end

step 'テストのためMarketPriceデータを投入する' do
  #material data
  create(:market_price, :type_id => 34, :adjusted_price => 10.0, :average_price => 10.0)
  create(:market_price, :type_id => 35, :adjusted_price => 10.0, :average_price => 10.0)
  create(:market_price, :type_id => 36, :adjusted_price => 10.0, :average_price => 10.0)
  create(:market_price, :type_id => 37, :adjusted_price => 10.0, :average_price => 10.0)
end

step 'テストのためIndustrySystemデータを投入する' do
  create(:industry_system_jita)
  create(:industry_system_nonni)
end