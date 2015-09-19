require_relative 'base_modifier'

class LastRealValueWinsModifier < BaseModifier
  LAST_REAL_VALUE_WINS = ['Last Avg CPC', 'Last Avg Pos']

  def modify_inner(hash, key)
    hash[key] = hash[key].select {|v| not (v.nil? or v == 0 or v == '0' or v == '')}.last
  end

end