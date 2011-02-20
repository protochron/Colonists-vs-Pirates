# Represents a tile on the map. It includes Clickable so that it can be clicked
# on to add or remove things from that tile.

require File.dirname(__FILE__) + '/clickable'

class Tile
  include Clickable
  
  attr_accessor :content, :x, :y, :width, :height
  
  def initialize(x, y, width, height)
    super
    
    # Retain the values passed into the constructor
    @x, @y = x, y
    @width, @height = width, height
    
    # Make certain to define this tile's clickable area
    clickable_area(x, y, x + width, y + height)
  end
  
  def unclicked(e)
    puts "Unclicked on tile at #{x}, #{y}"
  end
  
  
end