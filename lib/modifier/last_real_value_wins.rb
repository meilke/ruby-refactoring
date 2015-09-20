require_relative 'base_modifier'

class LastRealValueWinsModifier < BaseModifier

  def modify_inner(hash, key)
    hash[key] = hash[key].select {|v| not (v.nil? or v == 0 or v == '0' or v == '')}.last
  end

end