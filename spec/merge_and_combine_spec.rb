require File.expand_path('spec_helper', File.dirname(__FILE__))
require 'csv'
require 'merge_and_combine'

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
  let(:merge_and_combine) { MergeAndCombine.new('Keyword Unique ID') }

  context '#modify' do
    subject { merge_and_combine.modify(create_rows()) }
  
    it do
      should return_modified_elements [
        {'Keyword Unique ID' => [nil], 'Clicks' => [nil]},
        {'Keyword Unique ID' => ['4'], 'Clicks' => [5]},
        {'Keyword Unique ID' => ['44'], 'Clicks' => [55]}
      ]
    end

  end
end
