require_relative 'base_modifier'

class FloatValueModifier < BaseModifier

  def modify_inner(hash, key)
    hash[key] = hash[key][0].from_german_to_f.to_german_s
  end

end