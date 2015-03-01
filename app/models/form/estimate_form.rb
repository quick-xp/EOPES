class EstimateForm
  include ActiveModel::Model

  attr_accessor :estimate
  attr_accessor :estimate_blueprint
  attr_accessor :estimate_job_cost
  attr_accessor :user_id
  attr_accessor :jita_price

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

  def get_material_list
    EstimateMaterial.get_material_list(self.estimate_blueprint.type_id,
                                       self.estimate_blueprint.me,
                                       self.estimate_blueprint.te,
                                       self.estimate_blueprint.runs,
                                       self.jita_price)
  end

  #Market Data 一覧取得
  #Price が 安いもののTop10 を取得する
  def get_market_data(access_token, region_id, type_id)
    #マーケットデータリフレッシュ
    Market.refresh_market(region_id, type_id, access_token)
    MarketDetail.get_market_data_order_by_price(type_id,region_id,10)
  end

  #Total Estimate Result 再計算
  def set_total_price!(material_list)
    #sell total count
    product_quantity = IndustryActivityProduct.where(:typeID => self.estimate_blueprint.type_id, :activityID => 1).first
    self.estimate.sell_count = product_quantity.quantity * self.estimate_blueprint.runs

    #Total Volume
    self.estimate.total_volume = self.estimate.sell_count * InvType.get_type_volume(self.estimate.product_type_id)

    #Sell Total Price
    self.estimate.sell_total_price = self.estimate.sell_count * self.estimate.sell_price

    #material total cost
    self.estimate.material_total_cost = 0.0
    material_list.each do |m|
      self.estimate.material_total_cost += m.total_price
    end

    #Total Cost
    self.estimate.total_cost = self.estimate_job_cost.total_job_cost + self.estimate.material_total_cost

    #Profit
    self.estimate.profit = self.estimate.sell_total_price.to_f - self.estimate.total_cost.to_f
  end

end