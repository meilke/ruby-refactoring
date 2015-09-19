require_relative 'base_modifier'

class CancellationSaleAmountFactorModifier < BaseModifier
  
  def initialize(saleamount_factor, cancellation_factor, columns)
    super(columns)
    @saleamount_factor = saleamount_factor
    @cancellation_factor = cancellation_factor
  end

  def modify_inner(hash, key)
    hash[key] = (@cancellation_factor * @saleamount_factor * hash[key][0].from_german_to_f).to_german_s
  end

end