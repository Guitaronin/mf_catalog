require 'app'

#doc = CSVDoc.new(CSV_FILE)
#catalog = Catalog.new(doc.table)
#@categories = catalog.categorized_export.sort_by {|c| c[:priority]}

Prawn::Document.generate("implicit.pdf") do
  define_grid(:columns => 3, :rows => 5, :gutter => 10)
  grid(0,0).bounding_box do
    image image_files.first
  end
end

