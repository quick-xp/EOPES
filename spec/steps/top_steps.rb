# encoding: utf-8
require 'rails_helper'
step 'EOPESにアクセスする' do
  Capybara.app_host = 'http://localhost:3000/'
end

step 'トップページを表示する' do
  visit '/home'
end

step '画面にWelcomeと表示されていること' do
  expect(page).to have_content 'Welcome to EOPES'
  page.save_screenshot 'spec/tmp/test.png'
end