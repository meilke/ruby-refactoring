class FileBase

  DEFAULT_CSV_OPTIONS = { :col_sep => ',', :headers => :first_row }

  def parse(file)
    CSV.read(file, DEFAULT_CSV_OPTIONS)
  end

end