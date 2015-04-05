class MarketExplorerController < ApplicationController
  def index
  end

  #MarketGroup取得 取得
  def market_groups
    root_items = InvMarketGroup.all
    @items = []
    root_items.each do |item|
      v = Hash::new()
      v['id'] = item.marketGroupID
      v['parent'] = item.parentGroupID.nil? ? '#' : item.parentGroupID
      v['text'] = item.marketGroupName
      v['icon'] = false
      @items << v
    end

    #Item取得
    inv_types = InvType.where.not(:marketGroupID => nil)
    inv_types.each do |item|
      v = Hash::new()
      v['id'] = item.typeID + 100000 #idがかぶらないように100000足す
      v['parent'] = item.marketGroupID
      v['text'] = item.typeName
      v['icon'] = false
      @items << v
    end
    render json: @items
  end
end
