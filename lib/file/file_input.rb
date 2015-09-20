require_relative 'file_base'
require 'csv'
require 'date'

class FileInput < FileBase
  
  def initialize(base_path=nil)
    @base_path = base_path || ENV['HOME']
  end

  def latest_file_matching(name)
    files = Dir["#{@base_path}/*#{name}*.txt"]

    files.sort_by! do |file|
      last_date = /\d+-\d+-\d+_[[:alpha:]]+\.txt$/.match file
      last_date = last_date.to_s.match /\d+-\d+-\d+/

      date = DateTime.parse(last_date.to_s)
      date
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