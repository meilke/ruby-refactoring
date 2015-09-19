require_relative 'base_modifier'

class LastValueWinsModifier < BaseModifier

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

  def modify_inner(hash, key)
    hash[key] = hash[key].last
  end

end