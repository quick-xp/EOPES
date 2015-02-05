class EstimateForm
  include ActiveModel::Model

  attr_accessor :sell_price, :runs, :sell_count
  attr_accessor :blueprint_type_id, :blueprint_me, :blueprint_te
  attr_accessor :region_id, :solar_system_id
  attr_accessor :user_id
  attr_accessor :jita_price

  def get_material_list
    material_list = Array.new
    #材料一覧取得
    materials = IndustryActivityMaterial.where(:typeID => self.blueprint_type_id, :activityID => 1)
    materials.each do |m|
      r = EstimateMaterial.new
      r.type_id = m.materialTypeID
      r.require_count = m.quantity
      r.jita_average_price = self.jita_price.fetch(m.materialTypeID)
      r.total_price = m.quantity * 1.00 #TODO::price
      material_list << r
    end
    material_list
  end

  def get_jita_price(access_token)
    #材料一覧取得
    material_list = Array.new
    materials = IndustryActivityMaterial.where(:typeID => self.blueprint_type_id, :activityID => 1)
    jita_price = Hash::new()
    #Get The Forge Price
    materials.each do |material|
      json = access_token.get("https://crest-tq.eveonline.com/market/10000002/orders/sell/?type=https://api-sisi.testeveonline.com/types/" + material.materialTypeID.to_s + "/")
      markets = ActiveSupport::JSON.decode(json.response.env.body)
      markets = markets['items']
      # jita のみに絞り込む
      jita_markets = Array.new
      markets.each do |market|
        if market['location']['id'] == 60003760
          jita_markets << market['price']
        end
      end
      # sort
      sort_v = jita_markets.sort
      #average
      average_price = 0
      sum = 0.0
      count = 0
      sort_v.each do |v|
        sum += v
        count += 1
        if count > 10
          break;
        end
      end
      v = sum / count
      jita_price.store(material.materialTypeID,v)
    end
    self.jita_price = jita_price
  end

end