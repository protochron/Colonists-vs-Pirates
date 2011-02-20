
# This aggregates information for the user interface's current state. 
#
# click_mode represents what mode the interface is in for the next click.

class InterfaceState < Struct.new(:click_mode)
end