require_relative 'base_modifier'

class CancellationFactorModifier < BaseModifier
  
  def initialize(cancellation_factor)
    @cancellation_factor = cancellation_factor
  end

  def modify(hash)
    ['number of commissions'].each do |key|
      hash[key] = (@cancellation_factor * hash[key][0].from_german_to_f).to_german_s
    end
  end

end