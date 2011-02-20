# Represents a tile on the map. It includes Clickable so that it can be clicked
# on to add or remove things from that tile.

require File.dirname(__FILE__) + '/clickable'

class Tile
  include Clickable
  
  attr_accessor :content, :x, :y, :width, :height, :image
  
  def initialize(x, y, width, height)
    super
    
    # Retain the values passed into the constructor
    @x, @y = x, y
    @width, @height = width, height
    
    # Make certain to define this tile's clickable area
    clickable_area(x, y, x + width, y + height)
    
    @content = @image = nil
  end
  
  def unclicked(e)
    if e.state.click_mode == :regular_cannon then
      if @content.nil? then
        puts "Placed a regular cannon here!"
        @content = :regular_cannon
        @image   = Gosu::Image.new(e.sender, "images/cannon_reg.png")
        e.state.click_mode = nil
      end
    end
  end
  
  def draw()
    unless @content.nil? 
      x = @x + ((@width/2.0) - @image.width / 2.0)
      y = @y + ((@height/2.0) - @image.height / 2.0)
      
      @image.draw(x, y, 0.0)
    end
  end
  
  
end