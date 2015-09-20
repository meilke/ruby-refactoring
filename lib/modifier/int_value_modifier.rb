require_relative 'base_modifier'

class IntValuesModifier < BaseModifier

  def modify_inner(hash, key)
    hash[key] = hash[key][0].to_s
  end

end