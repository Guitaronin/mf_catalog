class CSVDoc
  attr_accessor :headers, :rows, :table
  
  def initialize(filepath)
    arr_of_arrs = FasterCSV.read(filepath)
    @headers = arr_of_arrs.shift
    @rows    = arr_of_arrs
    @table   = arr_of_arrs.map do |arr|
      row = {}
      headers.each do |header|
        index = headers.index(header)
        row[header] = arr[index]
      end
      row
    end
  end
  
  def method_missing(m, *args)
    if table.respond_to? m
      table.send(m, *args)
    else
      super
    end
  end
  
end
