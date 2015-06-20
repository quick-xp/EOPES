# encoding: utf-8
# language: ja

機能: アイテム見積もりを行う

  背景:
    前提 EOPESにアクセスする
    もし ルートページを表示する
    かつ ログインをクリックする

  シナリオ:見積もり一覧画面
    もし "Industry Profit Calc"リンクをクリックする
    ならば "Listing estimates"と表示されている
    ならば "product_estimate_001"という名前でスクリーンショットを撮る

  シナリオ:見積もり作成
    もし "Industry Profit Calc"リンクをクリックする
    かつ "New Estimate"リンクをクリックする
    ならば "Select Estimate Item"と表示されている
    ならば "product_estimate_002"という名前でスクリーンショットを撮る
    かつ "estimate_type_id"オプションの"Antimatter Charge L Blueprint"を選択する
    ならば "product_estimate_003"という名前でスクリーンショットを撮る
    かつ "Select"ボタンをクリックする



