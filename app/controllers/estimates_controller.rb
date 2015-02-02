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
    @estimate_form = Form::EstimateForm.new
    @estimate_form.blueprint_type_id = session[:type_id]
    #blueprint
    @estimate_form.blueprint_me = 0
    @estimate_form.blueprint_te = 0
    #location
    @region_list = Master::MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    @solar_system_list = [["", ""]]
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
    @region_list = Master::MapRegion.all.order(:regionName).map { |list| [list.regionName, list.regionID] }
    @region_id = params[:region_id]
    @solar_system_list = Master::MapSolarSystem.where(:regionID => @region_id)
    .order(:solarSystemName)
    .map { |list| [list.solarSystemName, list.solarSystemID] }
  end

  private
  def set_estimate
    @estimate = Estimate.find(params[:id])
  end

  def estimate_params
    params.require(:estimate).permit(:type_id, :user_id)
  end

end
