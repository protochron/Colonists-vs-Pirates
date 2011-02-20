
# Implements the basic behavior for a graphical, clickable UI button.

require_relative "clickable"
#require File.dirname(__FILE__) + '/game_object'

class Button
  include Clickable
  
  # Called whenever the mouse is clicked within the area of this object
  def clicked(e)
    puts "Clicked at position #{e.x, e.y}"
  end
  
  # Called whenever the mouse button is released within the area of this object
  def unclicked(e)
    puts "Unclicked at position #{e.x, e.y}"
  end
  
  # Called whenever the mouse moves into the clickable region of this object
  def mouse_in(e)
    puts "Moused moved in!"
  end
  
  # Called whenever the mouse moves out of the clickable region of this object
  def mouse_out(e)
    puts "Moused moved out!"
  end
  
end