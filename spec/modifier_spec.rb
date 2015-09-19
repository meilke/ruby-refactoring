require File.expand_path('spec_helper', File.dirname(__FILE__))
require './lib/modifier/base_modifier'
Dir['./lib/modifier/*.rb'].each {|file| require file }

describe 'Modifiers' do
  
  let(:columns) { ['Account ID'] }

  context LastValueWinsModifier do
    let(:hash) { {'Account ID' => ['1', '2']} }
    subject { LastValueWinsModifier.new(columns).modify(hash) }
  
    context 'leaves unconfigured columns untouched' do
      let(:columns) { ['something else'] }
      it { should eq({'Account ID' => ['1', '2']}) }
    end

    context 'takes the last value of a configured column' do
      it { should eq({'Account ID' => '2'}) }
    end
  end

  context LastRealValueWinsModifier do
    let(:hash) { {'Account ID' => ['1', '2', '0', 0, nil]} }
    subject { LastRealValueWinsModifier.new(columns).modify(hash) }
  
    context 'leaves unconfigured columns untouched' do
      let(:columns) { ['something else'] }
      it { should eq({'Account ID' => ['1', '2', '0', 0, nil]}) }
    end

    context 'takes the last value of a configured column' do
      it { should eq({'Account ID' => '2'}) }
    end
  end

  context IntValuesModifier do
    let(:hash) { {'Account ID' => [1, 2, 3]} }
    subject { IntValuesModifier.new(columns).modify(hash) }
  
    context 'leaves unconfigured columns untouched' do
      let(:columns) { ['something else'] }
      it { should eq({'Account ID' => [1, 2, 3]}) }
    end

    context 'converts the first element to string (weird...)' do
      it { should eq({'Account ID' => '1'}) }
    end
  end

end
