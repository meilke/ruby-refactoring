require File.expand_path('spec_helper', File.dirname(__FILE__))
require './lib/file/file_base'
Dir['./lib/file/*.rb'].each {|file| require file }

describe 'File operations' do
  
  context FileOutput do
    
    context 'sorts CSV files' do |o|
      it do
        output_path = FileOutput.new.sort_by('spec/test.txt', 'test')
        output_enumerator = FileInput.new.lazy_read(output_path)
        first_row = output_enumerator.next
        expect(first_row.field('test')).to eq('6')
        expect(first_row.field('test2')).to eq('7')
        second_row = output_enumerator.next
        expect(second_row.field('test')).to eq('5')
        expect(second_row.field('test2')).to eq('3')
      end
    end

  end

end
