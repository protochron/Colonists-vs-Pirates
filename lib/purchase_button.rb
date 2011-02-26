# Represents a button that is used to purchase new items.

require './lib/button'

class PurchaseButton < Button
  attr_reader :cost, :mode
  
  def initialize(*args)
    @window = args.pop
    super(*args)
    
    @coin_small = Gosu::Image.new(@window, "images/coin_small.png")
    @font = Gosu::Font.new(@window, "Arial", 20)
    
    self
  end
  
  def cost(val)
    @cost = val
    self
  end
  
  def mode(val)
    @mode = val
    self
  end

  
  def unclicked(e)
    # Change the game state to the type of this object for purcashing
    e.state.click_mode = @mode
  end
  
  def draw()
    super
    
    @coin_small.draw(@image_x, @image_y + 55, 0)
    @font.draw(@cost.to_s, @image_x + 20, @image_y + 52, ZOrder::UI)
  end
  
  
end
