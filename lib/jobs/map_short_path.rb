
# rails runner "Jobs::MapShortPath.new.run"
# solarSystem間の最小Jumps数を求める
require "CMapShortPath"
class Jobs::MapShortPath
  INF = 9999999.freeze

  def run
    puts "Job Start (MapShortPath)" + Time.now.to_s

    convert_list = get_convert_list_solar_system_id_to_array_num
    nodes = self.get_solar_system_analyze_target
    from_array = []
    to_array = []
    nodes.length.times do |i|
      from_array[i] = convert_list[nodes[i].fromSolarSystemID]
      to_array[i] = convert_list[nodes[i].toSolarSystemID]
    end

    #C言語 最小Jumps数
    c_map_short_path = CMapShortPath.new
    jumps = c_map_short_path.get_short_jump_count(from_array,to_array,nodes.length)

    puts "Job End (MapShortPath)" + Time.now.to_s
  end


  #Station間の最小Jump数を求める(ruby版)(性能問題により使用しない)
  def get_short_path_for_ruby
    convert_list = get_convert_list_solar_system_id_to_array_num

    edges = []
    nodes = self.get_solar_system_analyze_target
    #Warshall-Floyd Algorithm
    #Node初期化
    nodes.length.times do |i|
      nodes.length.times do |j|
        edges[i] ||= []
        if i == j
          edges[i][j] = 0
        else
          edges[i][j] = INF
        end
      end
    end

    #Node間距離の初期化
    nodes.length.times do |i|
      from = convert_list[nodes[i].fromSolarSystemID]
      to = convert_list[nodes[i].toSolarSystemID]
      distance = 1

      edges[from][to] = distance
      edges[to][from] = distance
    end

    #本計算
    nodes.length.times do |k|
      puts k.to_s + " / " + nodes.length.to_s + " complete(short jump count)"
      nodes.length.times do |i|
        nodes.length.times do |j|
          edges[i][j] = [edges[i][j], edges[i][k] + edges[k][j]].min
        end
      end
    end

    #結果格納
    MapJump.delete_all
    nodes.length.times do |i|
      map_jumps = []
      nodes.length.times do |j|
        if edges[i][j] < INF
          if convert_list.key(i).present? && convert_list.key(j).present?
            map_jumps << MapJump.new(:from_solar_system_id => convert_list.key(i),
                                     :to_solar_system_id => convert_list.key(j),
                                     :jump => edges[i][j])
          end
        end
      end
      MapJump.import map_jumps
      puts i.to_s + " / " + nodes.length.to_s + " complete(result insert)"
    end
  end

  #Solar System IDを0,1,2と配列で扱える値に変換する
  def get_convert_list_solar_system_id_to_array_num
    convert_list = Hash::new()
    maps = MapSolarSystem.all
    #maps = MapSolarSystem.where(:regionID => 10000002)
    maps.each_with_index do |m, i|
      convert_list[m.solarSystemID] = i
    end
    convert_list
  end

  #解析対象のSolarSystem
  def get_solar_system_analyze_target
    MapSolarSystemJumps.all
    #MapSolarSystemJumps.where(:toRegionID => 10000002, :fromRegionID => 10000002)
  end
end