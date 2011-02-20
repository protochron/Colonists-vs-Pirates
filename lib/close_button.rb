
# This button is used to exit the game.

require_relative "button"

class CloseButton < Button
  
  def initialize(*args)
    super(*args)
  end
  
  def unclicked(e)
    e.sender.close
  end
  
end