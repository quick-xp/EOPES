class MarketExplorerController < ApplicationController
  def index
  end

  #root 取得
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

    render json: @items
  end
end
