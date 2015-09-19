require_relative 'base_modifier'

class FloatValueModifier < BaseModifier

  FLOAT_VALUES = ['Avg CPC', 'CTR', 'Est EPC', 'newBid', 'Costs', 'Avg Pos']

  def modify_inner(hash, key)
    hash[key] = hash[key][0].from_german_to_f.to_german_s
  end

end