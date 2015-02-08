class EstimatesController < ApplicationController
  before_action :set_estimate, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @estimates = Estimate.all
    respond_with(@estimates)
  end

  def show
    respond_with(@estimate)
  end

  def select
    @estimate = Estimate.new
    respond_with(@estimate)
  end

  def new
    @estimate_form = EstimateForm.new
    @estimate_form.blueprint_type_id = session[:type_id]

    #init
    @estimate_form.runs = 1

    #blueprint
    @estimate_form.blueprint_me = 10
    @estimate_form.blueprint_te = 10

    #jita price
    @estimate_form.get_jita_price!(get_token)

    #material
    @material_list = @estimate_form.get_material_list

    #location
    @region_list = MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    @solar_system_list = [["", ""]]

    #location Job Cost 計算
    @estimate_form.re_calc_job_cost!(@material_list)

    #Product Sell Price
    @estimate_form.sell_price = 1.0

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
  end

  def create
    @estimate = Estimate.new(estimate_params)
    @estimate.save
    respond_with(@estimate)
  end

  def update
    @estimate.update(estimate_params)
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
    @estimate_form.region_id = @region_id
    @estimate_form.solar_system_id = @solar_system_id

    #Cost Re Calc
    @estimate_form.re_calc_job_cost!(@material_list)

    #session ReEntry
    session[:estimate_form] = @estimate_form
  end

  def set_material
    #material
    @material_list = session[:material_list]
    @estimate_form = session[:estimate_form]
    @estimate_form.blueprint_me = params["me"].to_i
    @estimate_form.runs = params["runs"].to_i
    @material_list.each_with_index do |m, i|
      #Re Calc Require Material
      @material_list[i].require_count = EstimateMaterial.require_material(@estimate_form.runs,
                                                                          @material_list[i].base_quantity,
                                                                          @estimate_form.blueprint_me,
                                                                          false)
      @material_list[i].price = params["price_" + i.to_s]
      @material_list[i].total_price = params["price_" + i.to_s].to_f * @material_list[i].require_count.to_f
    end

    #session ReEntry
    session[:material_list] = @material_list
    session[:estimate_form] = @estimate_form
  end

  def set_result
    #Get Session
    @material_list = session[:material_list]
    @estimate_form = session[:estimate_form]
    @estimate_form.sell_price = params["sell_price"].to_f

    #Calc Total Price
    @estimate_form.set_total_price!(@material_list)

    #session ReEntry
    session[:material_list] = @material_list
    session[:estimate_form] = @estimate_form
  end

  private
  def set_estimate
    @estimate = Estimate.find(params[:id])
  end

  def estimate_params
    params.require(:estimate).permit(:type_id, :user_id)
  end

end
