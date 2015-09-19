require_relative 'base_modifier'

class IntValuesModifier < BaseModifier

  INT_VALUES = [
    'Clicks',
    'Impressions',
    'ACCOUNT - Clicks',
    'CAMPAIGN - Clicks',
    'BRAND - Clicks',
    'BRAND+CATEGORY - Clicks',
    'ADGROUP - Clicks',
    'KEYWORD - Clicks'
  ]

  def modify_inner(hash, key)
    hash[key] = hash[key][0].to_s
  end

end