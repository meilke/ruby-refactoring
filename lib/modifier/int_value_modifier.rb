class IntValuesModifier

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

  def modify(hash)
    INT_VALUES.each do |key|
      hash[key] = hash[key][0].to_s
    end
  end

end