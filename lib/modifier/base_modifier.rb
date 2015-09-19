class String
  def from_german_to_f
    self.gsub(',', '.').to_f
  end
end

class Float
  def to_german_s
    self.to_s.gsub('.', ',')
  end
end

class BaseModifier
  
  def initialize(columns)
    @columns = columns
  end

  def modify(hash)
    @columns.each do |key|
      modify_inner(hash, key) if hash[key]
    end
    hash
  end

end