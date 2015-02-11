class EstimateForm
  include ActiveModel::Model

  attr_accessor :sell_price,:sell_count
  attr_accessor :estimate_blueprint
  attr_accessor :estimate_job_cost
  attr_accessor :user_id
  attr_accessor :jita_price
  attr_accessor :product_type_id
  attr_accessor :total_cost,:sell_total_price,:material_total_cost,:profit
  attr_accessor :total_volume

  def get_material_list
    material_list = Array.new
    #材料一覧取得
    materials = IndustryActivityMaterial.where(:typeID => self.estimate_blueprint.type_id, :activityID => 1)
    materials.each do |m|
      r = EstimateMaterial.new
      r.type_id = m.materialTypeID
      r.base_quantity = m.quantity
      r.require_count = EstimateMaterial.require_material(self.estimate_blueprint.runs, m.quantity, self.estimate_blueprint.me, false)
      r.adjusted_price = MarketPrice.where(:type_id => r.type_id).first.adjusted_price
      r.jita_average_price = self.jita_price.fetch(m.materialTypeID)
      r.jita_total_price = r.jita_average_price * r.require_count
      r.universe_average_price = MarketPrice.where(:type_id => r.type_id).first.average_price
      r.universe_total_price = r.universe_average_price * r.require_count
      r.volume = InvType.get_type_volume(m.materialTypeID)
      r.total_volume = r.volume * m.quantity
      r.price = r.jita_average_price.round(2)
      r.total_price = m.quantity * r.price
      material_list << r
    end
    material_list
  end

  def get_jita_price!(access_token)
    #材料一覧取得
    material_list = Array.new
    materials = IndustryActivityMaterial.where(:typeID => self.estimate_blueprint.type_id, :activityID => 1)
    jita_price = Hash::new()
    #Get The Forge Price
    materials.each do |material|
      #マーケットデータリフレッシュ(The Forge)
      Market.refresh_market(10000002, material.materialTypeID, access_token)
      #Jita Top 15 low Price
      market_details = MarketDetail
      .includes(:market)
      .where(station_id: 60003760, markets: {type_id: material.materialTypeID})
      .order(:price)
      .limit(15)

      #average
      average_price = 0
      sum = 0.0
      count = 0
      market_details.each do |v|
        sum += v.price
      end
      v = sum / market_details.size
      jita_price.store(material.materialTypeID, v)
    end
    self.jita_price = jita_price
  end

  #Market Data 一覧取得
  #Price が 安いもののTop10 を取得する
  def get_market_data(access_token,region_id,type_id)
    #マーケットデータリフレッシュ
    Market.refresh_market(region_id,type_id,access_token)
    MarketDetail
    .includes(:market)
    .where(markets: {type_id: type_id,region_id: region_id})
    .order(:price)
    .limit(10)
  end

  #Item の Region 平均価格を取得する
  #平均とは マーケットデータのTop 15 の価格の平均と定義する
  def get_region_average_price(region_id,type_id)
    market_details = MarketDetail
    .includes(:market)
    .where(markets: {type_id: type_id,region_id: region_id})
    .order(:price)
    .limit(15)

    #average
    sum = 0.0
    market_details.each do |v|
      sum += v.price
    end
    (sum / market_details.size).round(2)
  end

  #Item の Universe 平均価格を取得する
  def get_universe_average_price(type_id)
    price = MarketPrice.where(:type_id => type_id).first
    if price.nil?
      price = 0.0
    else
      price.average_price
    end
  end

  #Total Estimate Result 再計算
  def set_total_price!(material_list)
    #sell total count
    product_quantity = IndustryActivityProduct.where(:typeID => self.estimate_blueprint.type_id,:activityID => 1).first
    self.sell_count = product_quantity.quantity * self.estimate_blueprint.runs

    #Total Volume
    self.total_volume = self.sell_count * InvType.get_type_volume(self.product_type_id)

    #Sell Total Price
    self.sell_total_price = self.sell_count * self.sell_price

    #material total cost
    self.material_total_cost = 0.0
    material_list.each do |m|
      self.material_total_cost += m.total_price
    end

    #Total Cost
    self.total_cost = self.estimate_job_cost.total_job_cost + material_total_cost

    #Profit
    self.profit = self.sell_total_price.to_f - self.total_cost.to_f
  end

end