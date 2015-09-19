require_relative 'base_modifier'

class CancellationFactorModifier < BaseModifier
  
  def initialize(cancellation_factor, columns)
    super(columns)
    @cancellation_factor = cancellation_factor
  end

  def modify_inner(hash, key)
    hash[key] = (@cancellation_factor * hash[key][0].from_german_to_f).to_german_s
  end

end