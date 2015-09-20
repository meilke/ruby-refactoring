require_relative 'base_modifier'

class FactorModifier < BaseModifier
  
  def initialize(factor, columns)
    super(columns)
    @factor = factor
  end

  def modify_inner(hash, key)
    hash[key] = (@factor * hash[key][0].from_german_to_f).to_german_s
  end

end