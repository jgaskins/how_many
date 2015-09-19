class Container
  attr_reader :name, :image_url, :height, :width, :depth

  def initialize(name:, image_url: nil, height:, width:, depth:)
    @name = name
    @image_url = image_url
    @height = height
    @width = width
    @depth = depth
  end

  def volume
    height * width * depth
  end
end
