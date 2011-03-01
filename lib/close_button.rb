#
# Dan Norris and Cody Miller, 2011
#
# This button is used to exit the game.

require File.dirname(__FILE__) + "/button"

class CloseButton < Button
  
  def initialize(*args)
    super(*args)
  end
  
  def unclicked(e)
    e.sender.close
  end
  
end
