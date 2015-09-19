class LastValueWinsModifier

  LAST_VALUE_WINS = [
    'Account ID',
    'Account Name',
    'Campaign',
    'Ad Group',
    'Keyword',
    'Keyword Type',
    'Subid',
    'Paused',
    'Max CPC',
    'Keyword Unique ID',
    'ACCOUNT',
    'CAMPAIGN',
    'BRAND',
    'BRAND+CATEGORY',
    'ADGROUP',
    'KEYWORD'
  ]

  def modify(hash)
    LAST_VALUE_WINS.each do |key|
      hash[key] = hash[key].last
    end
  end

end