# Represents a tile on the map. It includes Clickable so that it can be clicked
# on to add or remove things from that tile.

%w{clickable sandbar cannon}.each do |file|
    require File.dirname(__FILE__) + '/' + file
end

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
    unless e.state.click_mode.nil?
      if @content.nil? then
        content = Kernel.const_get(e.state.click_mode[0]).new(x,y)
        if content.cost < $money 
          @content = content
          $money -= content.cost
        end
        @image   = e.state.click_mode[1]#Gosu::Image.new(e.sender, "images/sandbarge.png")
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
