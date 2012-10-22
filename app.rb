require 'rubygems'
require 'erb'
require 'prawn'
require 'fastercsv'
require 'pp'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

Dir.glob(File.expand_path(File.dirname(__FILE__)) + "/lib/*.rb").each do |lib|
  require lib
end

Dir.glob(File.expand_path(File.dirname(__FILE__)) + "/model/*.rb").each do |lib|
  require lib
end

include Helper

def html_from_erb
  template = File.new(File.join(APP_ROOT, 'template', 'catalog.html.erb')).read
  renderer = ERB.new(template)
  renderer.result(binding)
end

#doc = CSVDoc.new(CSV_FILE)
#catalog = Catalog.new(doc.table)
#@categories = catalog.categorized_export.sort_by {|c| c[:priority]}
#puts html_from_erb
