class EstimatesController < ApplicationController
  before_action :set_estimate, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @estimates = Estimate.all
    respond_with(@estimates)
  end

  def show
    #location
    @region_list = MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    #market sell order
    #Default は The Forge
    @sell_region_id = 10000002
    @product_market_list = @estimate_form.get_market_data(get_token,
                                                          @sell_region_id,
                                                          @estimate_form.estimate.product_type_id)

    respond_with(@estimate)
  end

  def select
    @estimate = Estimate.new
    respond_with(@estimate)
  end

  def new
    @estimate_form = EstimateForm.new

    #blueprint
    @estimate_blueprint = EstimateBlueprint.new
    @estimate_blueprint.type_id = session[:type_id]
    @estimate_blueprint.runs = 1
    @estimate_blueprint.me = 10
    @estimate_blueprint.te = 10
    @estimate_form.estimate_blueprint = @estimate_blueprint

    #jita price
    @estimate_form.get_jita_price!(get_token)

    #material
    @material_list = @estimate_form.get_material_list

    #location
    @region_list = MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    @solar_system_list = [["", ""]]

    #Job Cost 計算
    @estimate_job_cost = EstimateJobCost.new
    @estimate_job_cost.re_calc_job_cost!(@material_list,@estimate_blueprint.runs)
    @estimate_form.estimate_job_cost = @estimate_job_cost

    #Estimate
    @estimate_form.estimate = Estimate.new
    #Product Setting
    @estimate_form.estimate.product_type_id = @estimate_blueprint.get_product_type_id

    #market sell order
    #Default は The Forge
    @sell_region_id = 10000002
    @product_market_list = @estimate_form.get_market_data(get_token,
                                                          @sell_region_id,
                                                          @estimate_form.estimate.product_type_id)

    #Product Sell Order Average
    @product_region_sell_price_average =
        MarketDetail.get_region_average_price(@sell_region_id, @estimate_form.estimate.product_type_id)
    @product_universe_sell_price_average =
        MarketPrice.get_universe_average_price(@estimate_form.estimate.product_type_id)

    #Product Sell Price
    @estimate_form.estimate.sell_price = @product_region_sell_price_average

    #Total Estimate Result
    @estimate_form.set_total_price!(@material_list)
    #session
    session[:estimate_form] = @estimate_form
    session[:material_list] = @material_list
    respond_with(@estimate_form)
  end

  def select_new
    session[:type_id] = params[:estimate][:type_id]
    redirect_to new_estimate_path
  end

  def edit
    #jita price
    @estimate_form.get_jita_price!(get_token)

    #material
    @material_list = @estimate.estimate_materials

    #location 再設定
    @region_id = @estimate.estimate_job_cost.region_id
    @solar_system_id = @estimate.estimate_job_cost.solar_system_id

    #location
    @region_list = MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    @solar_system_list = MapSolarSystem.where(:regionID => @region_id)
    .order(:solarSystemName)
    .map { |list| [list.solarSystemName, list.solarSystemID] }

    #Cost Re Calc
    @estimate_form.estimate_job_cost.re_calc_job_cost!(@material_list,@estimate.estimate_blueprint.runs)

    #market sell order
    #Default は The Forge
    @sell_region_id = 10000002
    @product_market_list = @estimate_form.get_market_data(get_token,
                                                          @sell_region_id,
                                                          @estimate_form.estimate.product_type_id)

    #Product Sell Order Average
    @product_region_sell_price_average =
        MarketDetail.get_region_average_price(@sell_region_id, @estimate_form.estimate.product_type_id)
    @product_universe_sell_price_average =
        MarketPrice.get_universe_average_price(@estimate_form.estimate.product_type_id)

    #Total Estimate Result
    @estimate_form.set_total_price!(@material_list)
    #session
    session[:estimate_form] = @estimate_form
    session[:material_list] = @material_list
  end

  def create
    #Get Session
    @material_list = session[:material_list]
    @estimate_form = session[:estimate_form]

    #見積基本情報を設定
    @estimate = @estimate_form.estimate
    @estimate.user_id = get_current_user_id

    #見積詳細情報(Material)を設定
    @material_list.each do |material|
      @estimate.estimate_materials << material
    end

    #見積詳細情報(Blueprint)を設定
    @estimate.estimate_blueprint = @estimate_form.estimate_blueprint

    #見積詳細情報(JobCost)を設定
    @estimate.estimate_job_cost = @estimate_form.estimate_job_cost

    @estimate.save
    respond_with(@estimate)
  end

  def update
    #Get Session
    @material_list = session[:material_list]
    @estimate_form = session[:estimate_form]

    #見積基本情報を設定
    @estimate = @estimate_form.estimate
    @estimate.user_id = get_current_user_id

    #見積詳細情報(Material)を設定
    @material_list.each do |material|
      @estimate.estimate_materials << material
    end

    #見積詳細情報(Blueprint)を設定
    @estimate.estimate_blueprint = @estimate_form.estimate_blueprint

    #見積詳細情報(JobCost)を設定
    @estimate.estimate_job_cost = @estimate_form.estimate_job_cost

    @estimate.save
    respond_with(@estimate)
  end

  def destroy
    @estimate.destroy
    respond_with(@estimate)
  end

  def set_location
    @estimate_form = session[:estimate_form]
    @material_list = session[:material_list]

    # select value setting
    @region_id = params[:region_id]
    @solar_system_id = params[:solar_system_id]

    #region_list and solar_system_list
    @region_list = MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    @solar_system_list = MapSolarSystem.where(:regionID => @region_id)
    .order(:solarSystemName)
    .map { |list| [list.solarSystemName, list.solarSystemID] }

    #Re Set Location
    @estimate_form.estimate_job_cost.region_id = @region_id
    @estimate_form.estimate_job_cost.solar_system_id = @solar_system_id

    #Cost Re Calc
    @estimate_form.estimate_job_cost.re_calc_job_cost!(@material_list,@estimate_form.estimate_blueprint.runs)

    #session ReEntry
    session[:estimate_form] = @estimate_form
  end

  def set_material
    #material
    @material_list = session[:material_list]
    @estimate_form = session[:estimate_form]
    @estimate_form.estimate_blueprint.me = params["me"].to_i
    @estimate_form.estimate_blueprint.runs = params["runs"].to_i
    @material_list.each_with_index do |m, i|
      #Re Calc Require Material
      @material_list[i].require_count = EstimateMaterial.require_material(@estimate_form.estimate_blueprint.runs,
                                                                          @material_list[i].base_quantity,
                                                                          @estimate_form.estimate_blueprint.me,
                                                                          false)
      @material_list[i].price = params["price_" + i.to_s]
      @material_list[i].total_price = params["price_" + i.to_s].to_f * @material_list[i].require_count.to_f
      @material_list[i].total_volume = @material_list[i].require_count * @material_list[i].volume
    end

    #session ReEntry
    session[:material_list] = @material_list
    session[:estimate_form] = @estimate_form
  end

  def set_result
    #Get Session
    @material_list = session[:material_list]
    @estimate_form = session[:estimate_form]
    @estimate_form.estimate.sell_price = params["sell_price"].to_f

    #Calc Total Price
    @estimate_form.set_total_price!(@material_list)

    #session ReEntry
    session[:material_list] = @material_list
    session[:estimate_form] = @estimate_form
  end

  #Sell Market List
  def set_sell_market_list
    #Get Session
    @estimate_form = session[:estimate_form]

    # select value setting
    @sell_region_id = params[:sell_region_id]

    #region_list
    @region_list = MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }

    #market sell order
    @product_market_list = @estimate_form.get_market_data(get_token, @sell_region_id, @estimate_form.estimate.product_type_id)

    #Product Sell Order Average
    @product_region_sell_price_average =
        MarketDetail.get_region_average_price(@sell_region_id, @estimate_form.estimate.product_type_id)
    @product_universe_sell_price_average =
        MarketPrice.get_universe_average_price(@estimate_form.estimate.product_type_id)
  end

  private
  def set_estimate
    @estimate = Estimate.find(params[:id])
    #ページ認可
    page_permission(@estimate.user_id)

    @estimate_form = EstimateForm.new
    @estimate_form.estimate = @estimate
    @estimate_form.estimate_blueprint = @estimate.estimate_blueprint
    @estimate_form.estimate_job_cost = @estimate.estimate_job_cost

  end

  def estimate_params
    params.require(:estimate).permit(:type_id, :user_id)
  end

  #ページ認可
  def page_permission(user_id)
    if user_id.to_s != get_current_user_id.to_s
      redirect_to home_index_path
    end
  end

end
