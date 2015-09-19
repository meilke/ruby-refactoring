require File.expand_path('spec_helper', File.dirname(__FILE__))
require 'csv'
require 'merge_and_combine'

class MyModifier

  COLUMNS = [
    'Clicks'
  ]

  def modify(hash)
    COLUMNS.each do |key|
      hash[key] = hash[key].last
    end
  end

end

def create_rows
  Enumerator.new do |yielder|
    yielder.yield(CSV::Row.new(['Keyword Unique ID', 'Clicks'], [], true))
    yielder.yield(CSV::Row.new(['Keyword Unique ID', 'Clicks'], ['4', 5]))
    yielder.yield(CSV::Row.new(['Keyword Unique ID', 'Clicks'], ['44', 55]))
  end
end

RSpec::Matchers.define :return_modified_elements do |expected|
  read_elements = nil
  match do |enumerator|
    read_elements = read_from_enumerator(enumerator)
    read_elements == expected
  end
  failure_message do |enumerator|
    "expected that #{enumerator} would return #{expected.inspect}, but it returned #{read_elements.inspect}"
  end
end

describe MergeAndCombine do
  let(:modifier) { [] }
  let(:keyword_unique_id) { 'Keyword Unique ID' }

  context '#modify' do
    subject { MergeAndCombine.new(keyword_unique_id, modifier).process(create_rows(), create_rows()) }
  
    context 'with no modifiers' do
      it do
        should return_modified_elements [
          {'Keyword Unique ID' => [nil, nil], 'Clicks' => [nil, nil]},
          {'Keyword Unique ID' => ['4', '4'], 'Clicks' => [5, 5]},
          {'Keyword Unique ID' => ['44', '44'], 'Clicks' => [55, 55]}
        ]
      end
    end

    context 'with modifier on Clicks column' do
      let(:modifier) { [ MyModifier.new ] }
      it do
        should return_modified_elements [
          {'Keyword Unique ID' => [nil, nil], 'Clicks' => nil},
          {'Keyword Unique ID' => ['4', '4'], 'Clicks' => 5},
          {'Keyword Unique ID' => ['44', '44'], 'Clicks' => 55}
        ]
      end
    end

  end
end
