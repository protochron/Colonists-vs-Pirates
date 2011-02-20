
# Implements the basic behavior for a graphical, clickable UI button.

require_relative "clickable"
#require File.dirname(__FILE__) + '/game_object'

class Button
  include Clickable
  
  attr_accessor :image
  
  def initialize(ix, iy, iz, image, image_hover=nil)
    @image_hover = image_hover
    @image = image
    @image_x, @image_y, @image_z = ix, iy, iz
    
    self.clickable_area(ix, iy, ix + image.width, iy + image.height)
  end
  
  def draw()
    if @state == :hover && @image_hover then
      @image_hover.draw(@image_x, @image_y, @image_z)
    else
      @image.draw(@image_x, @image_y, @image_z)
    end
  end
  
  # Called whenever the mouse is clicked within the area of this object
  def clicked(e)
    
  end
  
  # Called whenever the mouse button is released within the area of this object
  def unclicked(e)
    puts "Unclicked!"
  end
  
  # Called whenever the mouse moves into the clickable region of this object
  def mouse_in(e)
    @state = :hover
  end
  
  # Called whenever the mouse moves out of the clickable region of this object
  def mouse_out(e)
    @state = nil
  end
  
end