# encoding: utf-8
require 'rails_helper'
require 'spec_helper'

step 'EOPESにアクセスする' do
  Capybara.app_host = 'http://localhost:3000/'

end

step 'ルートページを表示する' do
  #visit '/'
end

step 'ログインリンクをクリックする' do



  #puts mock_login[:eve_online]
  visit "/users/auth/eve_online"
  #puts page.response_headers["Location"].to_s
  #page.first("img").click
  #find("img[@alt='Eve sso login buttons large black'").click
end

step '画面にWelcomeと表示されていること' do
  expect(page).to have_content 'Welcome to EOPES'
  page.save_screenshot 'spec/tmp/test.png'
end