require File.expand_path('spec_helper', File.dirname(__FILE__))
require './lib/modifier/base_modifier'
Dir['./lib/modifier/*.rb'].each {|file| require file }

describe 'Modifiers' do
  
  context 'LastValueWinsModifier' do
    let(:hash) { {'Account ID' => ['1', '2']} }
  
    it do
      LastValueWinsModifier.new(['Account ID']).modify(hash)
      expect(hash).to eq({'Account ID' => '2'})
    end

  end
end
