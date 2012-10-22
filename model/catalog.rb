class Catalog
  attr_reader :listings
  def initialize(arr_of_hashes)
    @listings = arr_of_hashes.map do |row|
      Product.new(row)
    end
    untangle_groups!
  end

  def groups
    @groups ||= listings.select {|l| l.configurable?}.map {|l| Group.new(l.stylenumber, self)}.sort_by {|g| g.listings.first.priority}
  end

  def prioritize!
    @listings = listings.sort_by {|l| l.priority}
  end
  alias :sort! :prioritize!

  def method_missing(m, *args)
    if listings.respond_to? m
      listings(m, *args)
    else
      super
    end
  end

  def categorized_export
    export = []
    self.class.full_categories.each do |cat|
      selected = groups.select {|g| g.full_category == cat}
      export << {:name => cat,
                 :priority => self.class.full_categories_map[cat],
                 :images   => selected.map {|g| g.images}.flatten}
    end
    export
  end

  def self.full_categories
    cats = []
    Product::CATEGORIES.keys.each do |cat|
      Product::SUB_CATEGORIES.keys.each do |scat|
        cats << "#{cat} #{scat}"
      end
    end
    cats
  end

  def self.full_categories_map
    cats = {}
    Product::CATEGORIES.each do |cat, p_score|
      Product::SUB_CATEGORIES.each do |scat, s_p_score|
        p = p_score.to_f + s_p_score
        f_cat = "#{cat} #{scat}"
        cats[f_cat] = p
      end
    end
    cats
  end

  private

  def untangle_groups!
    groups.each do |group|
      other_group = groups.find {|g| g.name != group.name && g.name.include?(group.name)}
      if other_group
        removal_key = other_group.name.sub(group.name, '')
        group.clean!(removal_key)
      end
    end
  end
end
