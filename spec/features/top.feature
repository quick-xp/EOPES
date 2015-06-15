# encoding :utf-8
Feature: トップページアクセス
 Scenario： トップページアクセス
  Given EOPESにアクセスする
  When トップページを表示する
  Then 画面にWelcomeと表示されていること
