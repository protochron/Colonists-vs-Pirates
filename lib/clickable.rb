#
# Dan Norris and Cody Miller, 2011

# Implements behavior for objects that can be clicked.

#require File.dirname(__FILE__) + '/game_object'

require File.dirname(__FILE__) + "/mouse_event"

module Clickable
  #attr_reader :clickable_area
  
  def clickable_area(px, py, qx, qy)
    @px, @py = px, py
    @qx, @qy = qx, qy
  end
  
  # Determines if a point is within the clickable region of this object
  def within_clickable?(x, y)
    if x >= @px && x <= @qx then
      if y >= @py && y <= @qy then
        return true
      end
    end
    
    false
  end
  
  # Called whenever the mouse is clicked within the area of this object
  def clicked(mouse_event)
  end
  
  # Called whenever the mouse button is released within the area of this object
  def unclicked(mouse_event)
  end
  
  # Called whenever the mouse moves into the clickable region of this object
  def mouse_in(mouse_event)
  end
  
  # Called whenever the mouse moves out of the clickable region of this object
  def mouse_out(mouse_event)
  end
  
end
