class Product
  include Helper
  attr_accessor :group

  CATEGORIES     = {'classic'   => 1, 'vintage'       => 2, 'perfected' => 3}
  SUB_CATEGORIES = {'solitaire' => 0.1, 'three stone' => 0.2, 'channel' => 0.3, 'shared prong' => 0.4, 'micropave' => 0.5}
  
  def initialize(hash)
    @attrs = hash
    return self
  end
  
  def image
    image_files.find {|i| File.basename(i, '.jpg').sub('grid', '').strip == self.stylenumber}
  end

  def priority
    CATEGORIES[category].to_f + SUB_CATEGORIES[sub_category]
  end

  def configurable?
    type == 'configurable'
  end

  def simple?
    type == 'simple'
  end

  def category
    name.split[1].downcase
    #name.sub(/\S+\s).sub(/engagement ring$|wedding band$/i, '')
  end

  def sub_category
    return 'micropave' if name.include?('pave')
    words = name.split
    if words.size == 5
      words[2].downcase
    else
      words[2..3].join(' ').downcase
    end
  end

  def type
    @attrs['type']
  end
  
  def method_missing(m)
    @attrs[m.to_s]
  end
end
