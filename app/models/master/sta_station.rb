# == Schema Information
#
# Table name: staStations
#
#  stationID                :integer          not null, primary key
#  security                 :integer
#  dockingCostPerVolume     :float(53)
#  maxShipVolumeDockable    :float(53)
#  officeRentalCost         :integer
#  operationID              :integer
#  stationTypeID            :integer
#  corporationID            :integer
#  solarSystemID            :integer
#  constellationID          :integer
#  regionID                 :integer
#  stationName              :string(100)
#  x                        :float(53)
#  y                        :float(53)
#  z                        :float(53)
#  reprocessingEfficiency   :float(53)
#  reprocessingStationsTake :float(53)
#  reprocessingHangarFlag   :integer
#

class StaStation < ActiveRecord::Base
  self.table_name = 'staStations'
  establish_connection(:EveMasterDB)
end
