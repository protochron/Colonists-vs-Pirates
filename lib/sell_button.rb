# Represents a button that is used to sell current items.

require './lib/button'

class SellButton < Button
  
  def initialize(*args)
    super(*args)
  end
  
  def unclicked(e)
    # Change the game state to "selling"
    e.state.click_mode = :sell
  end
  
end
