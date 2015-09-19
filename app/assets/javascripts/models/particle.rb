class Particle
  attr_reader :name, :plural_name, :image_url, :height, :width, :depth

  def initialize(name:, plural_name:, image_url: nil, height:, width:, depth:)
    @name = name
    @plural_name = plural_name
    @image_url = image_url
    @height = height
    @width = width
    @depth = depth
  end

  def volume
    height * width * depth
  end
end
