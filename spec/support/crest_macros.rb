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

  # region:Lonetrek type_id:23783
  def get_dummy_market_data2
    before(:each) do
      crest_market_data = Hash::new()

      #Nonni I - Caldari Navy Assembly Plant
      data1 = {
          "volume" => 5.0,
          "buy" => false,
          "price" => 12.0,
          "duration" => 90,
          "location" => {"id" => "60003862"},
          "issued" => "2015-03-26T23:26:44"
      }

      data2 = {
          "volume" => 5.0,
          "buy" => false,
          "price" => 13.0,
          "duration" => 90,
          "location" => {"id" => "60003862"},
          "issued" => "2015-03-26T23:26:44"
      }

      data3 = {
          "volume" => 5.0,
          "buy" => false,
          "price" => 14.0,
          "duration" => 90,
          "location" => {"id" => "60003862"},
          "issued" => "2015-03-26T23:26:44"
      }

      crest_market_data['totalCount_str'] = 3
      items = Array.new
      items << data1
      items << data2
      items << data3
      crest_market_data['items'] = items
      #stub
      #マーケットデータは常に固定の値を返す
      allow(Market).to receive(:get_market_data_from_crest)
                           .with("10000016",23783,anything())
                           .and_return(crest_market_data)
    end
  end

  def get_dummy_market_data_for_controller
    get_dummy_market_data
    before(:each) do
      allow(controller).to receive(:get_token).and_return("")
    end
  end

  def get_dummy_market_data2_for_controller
    get_dummy_market_data2
    before(:each) do
      allow(controller).to receive(:get_token).and_return("")
    end
  end

end