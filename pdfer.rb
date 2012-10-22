require 'app'

doc = CSVDoc.new(CSV_FILE)
catalog = Catalog.new(doc.table)
categories = catalog.categorized_export.sort_by {|c| c[:priority]}
image_slices = []
categories.each do |cat|
  cat[:images].each_slice(3) do |slice|
    image_slices << slice.map {|path| {:image => path, :image_width => 150}}
  end
end

Prawn::Document.generate("mf_catalog.pdf") do
  image_slices.each_slice(4) do |set|
    table( set, :cell_style => {:border_color => "FFFFFF"} )
    start_new_page
  end
end

