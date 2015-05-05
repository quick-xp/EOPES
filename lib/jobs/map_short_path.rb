# rails runner "Jobs::MapShortPath.new.run"
# solarSystem間の最小Jumps数を求める
require "CMapShortPath"
require "csv"
class Jobs::MapShortPath
  INF = 9999999.freeze

  def run(temp_file_full_path)
    puts "Job Start (MapShortPath)" + Time.now.to_s

    convert_list = get_convert_list_solar_system_id_to_array_num
    nodes = self.get_solar_system_analyze_target
    from_array = []
    to_array = []
    nodes.length.times do |i|
      from_array[i] = convert_list[nodes[i].fromSolarSystemID]
      to_array[i] = convert_list[nodes[i].toSolarSystemID]
    end

    #C言語 最小Jumps数(ファイル出力する)
    c_map_short_path = CMapShortPath.new
    c_map_short_path.export_short_jump_count(from_array, to_array, nodes.length, temp_file_full_path)

    #Conver List Key Value反転
    de_convert_list = convert_list.invert
    #出力結果読み取り,格納
    map_jumps = []
    count = 0
    insert_count = 0
    MapJump.delete_all
    CSV.foreach(temp_file_full_path) { |row|
      from = de_convert_list[row[0].to_i]
      to = de_convert_list[row[1].to_i]
      jump_c = row[2].to_i
      #配列IDから逆引きできた場合のみ格納する
      if from.present? && to.present?
        map_jumps << MapJump.new(:from_solar_system_id => from,
                                 :to_solar_system_id => to,
                                 :jump => jump_c.to_i)
        count += 1
      end

      #一定間隔でDBに格納する
      if count == 3000
        count = 0
        insert_count = insert_count + 1
        MapJump.import map_jumps
        puts "bulk insert count " + insert_count.to_s
        map_jumps = []
      end
    }
    MapJump.import map_jumps

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