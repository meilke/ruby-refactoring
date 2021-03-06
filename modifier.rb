require_relative 'lib/merge_and_combine'
require_relative 'lib/file/file_input'
require_relative 'lib/file/file_output'
Dir['./lib/modifier/*.rb'].each {|file| require file }
require 'csv'

class Modifier

  KEYWORD_UNIQUE_ID = 'Keyword Unique ID'
  LAST_VALUE_WINS = ['Account ID', 'Account Name', 'Campaign', 'Ad Group', 'Keyword', 'Keyword Type', 'Subid', 'Paused', 'Max CPC', 'Keyword Unique ID', 'ACCOUNT', 'CAMPAIGN', 'BRAND', 'BRAND+CATEGORY', 'ADGROUP', 'KEYWORD']
  LAST_REAL_VALUE_WINS = ['Last Avg CPC', 'Last Avg Pos']
  INT_VALUES = ['Clicks', 'Impressions', 'ACCOUNT - Clicks', 'CAMPAIGN - Clicks', 'BRAND - Clicks', 'BRAND+CATEGORY - Clicks', 'ADGROUP - Clicks', 'KEYWORD - Clicks']
  FLOAT_VALUES = ['Avg CPC', 'CTR', 'Est EPC', 'newBid', 'Costs', 'Avg Pos']
  CANCELLATION_VALUES = ['number of commissions']
  CANCELLATION_SALE_AMOUNT_VALUES = ['Commission Value', 'ACCOUNT - Commission Value', 'CAMPAIGN - Commission Value', 'BRAND - Commission Value', 'BRAND+CATEGORY - Commission Value', 'ADGROUP - Commission Value', 'KEYWORD - Commission Value']

  def initialize(saleamount_factor, cancellation_factor)
    @saleamount_factor = saleamount_factor
    @cancellation_factor = cancellation_factor
  end

  def modify(name_part, pattern, sorting_column)
    
    file_input = FileInput.new
    file_output = FileOutput.new

    input = file_input.latest_file_matching(name_part, pattern)
    output = input

    input = file_output.sort_by(input, sorting_column)
    input_enumerator = file_input.lazy_read(input)

    modifiers = [
      LastValueWinsModifier.new(LAST_VALUE_WINS),
      LastRealValueWinsModifier.new(LAST_REAL_VALUE_WINS),
      IntValuesModifier.new(INT_VALUES),
      FloatValueModifier.new(FLOAT_VALUES),
      FactorModifier.new(@cancellation_factor, CANCELLATION_VALUES),
      FactorModifier.new(@cancellation_factor * @saleamount_factor, CANCELLATION_SALE_AMOUNT_VALUES)
    ]

    merger = MergeAndCombine.new(KEYWORD_UNIQUE_ID, modifiers).process(input_enumerator)

    file_output.write_enumerator_paged(merger, output)

  end
end

modification_factor = 1
cancellaction_factor = 0.4
modifier = Modifier.new(modification_factor, cancellaction_factor)
modified = modifier.modify('project_2012-07-27_2012-10-10_performancedata', /\d+-\d+-\d+_[[:alpha:]]+\.txt$/, 'Clicks')

puts 'DONE modifying'