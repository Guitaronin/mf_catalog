module Helper
  APP_ROOT = File.expand_path(File.join(  File.dirname(__FILE__), '..')  )
  CSV_FILE = 'data/all_ff_products_together_subdivied.csv'
  
  def image_dir
    File.join(APP_ROOT, 'data', 'images')
  end
    
  def image_files
    dirs = Dir.glob("#{image_dir}/**/*.jpg")
  end
end
