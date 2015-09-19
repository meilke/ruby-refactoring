require_relative 'combiner'

class MergeAndCombine

  def initialize(keyword_unique_id)
    @keyword_unique_id = keyword_unique_id
  end

  def modify(input_enumerator)
    
    combiner = Combiner.new do |value|
      value[@keyword_unique_id]
    end.combine(input_enumerator)

    Enumerator.new do |yielder|
      while true
        begin
          list_of_rows = combiner.next
          merged = combine_hashes(list_of_rows)
          yielder.yield(combine_values(merged))
        rescue StopIteration
          break
        end
      end
    end
  end

  private

  def combine_values(hash)
    hash
  end

  def combine_hashes(list_of_rows)
    keys = []
    list_of_rows.each do |row|
      next if row.nil?
      row.headers.each do |key|
        keys << key
      end
    end
    result = {}
    keys.each do |key|
      result[key] = []
      list_of_rows.each do |row|
        result[key] << (row.nil? ? nil : row[key])
      end
    end
    result
  end

end