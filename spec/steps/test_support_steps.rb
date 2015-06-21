# encoding: utf-8
require 'rails_helper'
require 'spec_helper'
# Dummy crest
step 'テストのためダミーマーケットデータを使用するようにする' do
  #WebMock.stub_request(:any, "http://localhost:3011/home").to_return(status: 404,:body => "hello")
  #puts Net::HTTP.get(URI.parse("http://localhost:3011/home"))

  WebMock.stub_request(:any, get_crest_market_url(10000002, 34, "sell")).to_return(:body => "Hello World!")
  WebMock.stub_request(:any, get_crest_market_url(10000002, 35, "sell")).to_return( :body => "Hello World!")
  WebMock.stub_request(:any, get_crest_market_url(10000002, 36, "sell")).to_return( :body => "Hello World!")
  WebMock.stub_request(:any, get_crest_market_url(10000002, 37, "sell")).to_return( :body => "Hello World!")
end