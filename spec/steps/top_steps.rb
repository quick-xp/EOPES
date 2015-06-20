# encoding: utf-8
require 'rails_helper'
require 'spec_helper'
step 'EOPESにアクセスする' do
  Capybara.app_host = 'http://localhost:3011/'
end

step 'ルートページを表示する' do
  visit '/'
end

step 'ログインをクリックする' do
  #visit "/users/auth/eve_online"
  page.first("img").click
end

#step '画面にWelcomeと表示されていること' do
#  expect(page).to have_content 'Welcome to EOPES'
#  page.save_screenshot 'spec/tmp/test.png'
#end