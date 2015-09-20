require_relative 'file_base'
require 'csv'
require 'date'

class FileInput < FileBase
  
  DATE_PATTERN = /\d+-\d+-\d+/

  def initialize(base_path=nil)
    @base_path = base_path || ENV['HOME']
  end

  def latest_file_matching(name_part, pattern)
    files = Dir["#{@base_path}/*#{name_part}*.txt"].select{ |file| file[pattern] }

    files.sort_by! do |file|
      last_date = file.to_s.match DATE_PATTERN
      DateTime.parse(last_date.to_s)
    end

    throw RuntimeError if files.empty?

    files.last
  end

  def lazy_read(path)
    Enumerator.new do |yielder|
      CSV.foreach(path, DEFAULT_CSV_OPTIONS) do |row|
        yielder.yield(row)
      end
    end
  end

end