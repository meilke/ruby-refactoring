require File.expand_path('spec_helper', File.dirname(__FILE__))
require './lib/file/file_base'
Dir['./lib/file/*.rb'].each {|file| require file }

def create_my_rows
  Enumerator.new do |yielder|
    yielder.yield({'test' => '5', 'test2' => 6})
    yielder.yield({'test' => '5', 'test2' => 6})
    yielder.yield({'test' => '5', 'test2' => 6})
    yielder.yield({'test' => '5', 'test2' => 6})
    yielder.yield({'test' => '5', 'test2' => 6})
  end
end

describe 'File operations' do
  
  context FileOutput do
    
    context 'sorts CSV files' do
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

    context 'writes paged files' do
      it do
        FileOutput.new.write_enumerator_paged(create_my_rows, 'spec/test.out.txt', 2)
        expect(Dir['spec/test.out_*.txt'].length).to eq(3)
      end
    end

  end

  context FileInput do
    
    context 'gets latest file matching pattern' do
      it do
        latest = FileInput.new('workspace').latest_file_matching('project_2012-07-27_2012-10-10_performancedata', /\d+-\d+-\d+_[[:alpha:]]+\.txt$/)
        expect(latest).to eq('workspace/project_2012-07-27_2012-10-10_performancedata.txt')
      end
    end

  end

end
