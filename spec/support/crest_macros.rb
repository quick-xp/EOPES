module CrestMacros
  def get_dummy_market_data
    before(:each) do
      crest_market_data = Hash::new()

      data1 = {
          "volume" => 10,
          "buy" => false,
          "price" => 5.9,
          "duration" => 90,
          "location" => {"id" => "60003760"},
          "issued" => "2015-03-26T23:26:44"
      }
      data2 = {
          "volume" => 10,
          "buy" => false,
          "price" => 5.91,
          "duration" => 90,
          "location" => {"id" => "60003760"},
          "issued" => "2015-03-26T23:26:44"
      }

      crest_market_data['totalCount_str'] = 2
      items = Array.new
      items << data1
      items << data2
      crest_market_data['items'] = items
      #stub
      #マーケットデータは常に固定の値を返す
      allow(Market).to receive(:get_market_data_from_crest).and_return(crest_market_data)
    end
  end
end