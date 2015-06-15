# encoding: utf-8

step 'EOPESにアクセスする' do
  Capybara.app_host = 'http://localhost:3010/'
end

step 'トップページを表示する' do
  visit '/home'
end

step '画面にWelcomeと表示されること' do
  expect(page).to have_contenxt 'Welcome to EOPES'
  page.save_screenshot 'test.png'
end