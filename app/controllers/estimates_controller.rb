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
    #blueprint
    @estimate_form.blueprint_me = 0
    @estimate_form.blueprint_te = 0
    #location
    @region_list = MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    @solar_system_list = [["", ""]]
    #jita price
    @estimate_form.get_jita_price(get_token)
    #material
    @material_list = @estimate_form.get_material_list
    #session
    session[:estimate_form] = @estimate_form

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
    @region_list = MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    @region_id = params[:region_id]
    @solar_system_list = MapSolarSystem.where(:regionID => @region_id)
    .order(:solarSystemName)
    .map { |list| [list.solarSystemName, list.solarSystemID] }
  end

  def set_material
    #material
    e = session[:estimate_form]
    @material_list = e.get_material_list
    @material_list.each_with_index do |m, i|
      @material_list[i].price = params["price_" + i.to_s]
      @material_list[i].total_price = params["price_" + i.to_s].to_f * @material_list[i].require_count.to_f
    end
  end

  private
  def set_estimate
    @estimate = Estimate.find(params[:id])
  end

  def estimate_params
    params.require(:estimate).permit(:type_id, :user_id)
  end

end
