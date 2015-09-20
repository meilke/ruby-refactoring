require_relative 'file_base'

class FileOutput < FileBase

  def sort_by(path, column)
    output_path = "#{path}.sorted"
    content_as_table = parse(path)
    headers = content_as_table.headers
    index_of_key = headers.index(column)
    content = content_as_table.sort_by { |a| -a[index_of_key].to_i }
    write(content, headers, output_path)
  end

  private

  def write(content, headers, path)
    CSV.open(path, 'wb', DEFAULT_CSV_OPTIONS) do |csv|
      csv << headers
      content.each do |row|
        csv << row
      end
    end
    path
  end

end