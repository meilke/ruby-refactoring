class LastRealValueWinsModifier
  LAST_REAL_VALUE_WINS = ['Last Avg CPC', 'Last Avg Pos']

  def modify(hash)
    LAST_REAL_VALUE_WINS.each do |key|
      hash[key] = hash[key].select {|v| not (v.nil? or v == 0 or v == '0' or v == '')}.last
    end
  end

end