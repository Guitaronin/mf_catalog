class Group
  include Helper
  attr_reader :name
  attr_accessor :listings

  def initialize(name, catalog)
    @name     = name
    @listings = catalog.listings.select do |l|
      l.stylenumber.include? name
    end
  end

  def clean!(removal_key)
    @removal_key = removal_key
    self.listings = listings.reject {|l| l.stylenumber.sub(/^#{name}/, '').include?(removal_key)}
  end
  
  def listing_names
    listings.map {|l| l.stylenumber}
  end

  def images
    #matched_listings.map {|l| l.image}
    matches = image_files.select do |i|
      File.basename(i) =~ /^#{name}/    
    end
    
    if @removal_key
      matches = matches.reject do |i|
        File.basename(i).include? @removal_key
      end
    end
    matches.map {|i| i.sub(/.+\/images/, '/images')}
  end

  def has_image?
    images.any?
  end

  def matched_listings
    listings.select {|l| l.image}
  end

  def category
    self.listings.first.category
  end

  def sub_category
    self.listings.first.sub_category
  end

  def full_category
    "#{category} #{sub_category}"
  end

  def priority
    self.listings.first.priority
  end
end
