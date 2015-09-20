require_relative 'file_base'

class FileOutput < FileBase

  DEFAULT_LINES_PER_FILE = 120000

  def sort_by(path, column)
    output_path = "#{path}.sorted"
    content_as_table = parse(path)
    headers = content_as_table.headers
    index_of_key = headers.index(column)
    content = content_as_table.sort_by { |a| -a[index_of_key].to_i }
    write_enumerable(content, headers, output_path)
  end

  def write_enumerator_paged(enumerator, path, lines_per_file=DEFAULT_LINES_PER_FILE)
    done = false
    file_index = 0
    file_name = path.gsub('.txt', '')
    while not done do
      CSV.open(file_name + "_#{file_index}.txt", 'wb', DEFAULT_CSV_OPTIONS) do |csv|
        headers_written = false
        line_count = 0
        while line_count < lines_per_file
          begin
            merged = enumerator.next
            if not headers_written
              csv << merged.keys
              headers_written = true
              line_count +=1
            end
            csv << merged
            line_count +=1
          rescue StopIteration
            done = true
            break
          end
        end
        file_index += 1
      end
    end
  end

  private

  def write_enumerable(enumerable, headers, path)
    CSV.open(path, 'wb', DEFAULT_CSV_OPTIONS) do |csv|
      csv << headers
      enumerable.each do |row|
        csv << row
      end
    end
    path
  end

end