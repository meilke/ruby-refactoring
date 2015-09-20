require_relative 'base_modifier'

class LastValueWinsModifier < BaseModifier

  def modify_inner(hash, key)
    hash[key] = hash[key].last
  end

end