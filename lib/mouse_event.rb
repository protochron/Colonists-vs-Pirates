#
# Dan Norris and Cody Miller, 2011

# This is used to wrap up details about a mouse click event
# 
# In the cases that this object is created when a mouse button is clicked, 
# @button is set to the Gosu default for mouse buttons 
# (Gosu::MsLeft, Gosu::MsRight).
#
# In the case that this object is created when a mouse is moved, the 
# button field is set to nil.
#
# The sender field is always from where the click originated (the GameWindow).
# The state is a reference to the interface's current state.

class MouseEvent < Struct.new(:x, :y, :button, :sender, :state)
end