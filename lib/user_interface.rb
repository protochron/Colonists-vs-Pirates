# This is the module that provides all the UserInterface methods.
# Its main purpose is to keep the GameWindow class as clean as possible.

require './lib/button'
require './lib/purchase_button'

module UserInterface

  def initialize(*params)
    super(*params)
    
    @mouse_pos_x, @mouse_pos_y = 0,0

    exit = Gosu::Image.new(self, "images/exit.png")
    purchase = Gosu::Image.new(self, "images/purchase.png")
    cannon_reg = Gosu::Image.new(self, "images/cannon_reg.png")
    cannon_fire = Gosu::Image.new(self, "images/cannon_fire.png")
    barrel = Gosu::Image.new(self, "images/barrel.png")
    sandbar = Gosu::Image.new(self, "images/sandbar.png")
    
    @info_bar_bg = Gosu::Image.new(self, "images/info_menu_background.png")
    @purchase_bar_bg = Gosu::Image.new(self, 
                                      "images/purchase_menu_background.png")
    
    @ui = Button.new(725, 0, ZOrder::Background, exit),
          Button.new(675, 0, ZOrder::Background, purchase),
          PurchaseButton.new(40, 525, ZOrder::Background, cannon_reg, self).cost(15),
          PurchaseButton.new(140, 525, ZOrder::Background, cannon_fire, self).cost(30),
          PurchaseButton.new(240, 525, ZOrder::Background, barrel, self).cost(15),
          PurchaseButton.new(340, 525, ZOrder::Background, sandbar, self).cost(40)
  
  end
  
  def set_window_ref_for_gui(window)
    @window = window
    
    @font = Gosu::Font.new(@window, "Arial", 20)
  end
  
  def mouse_update
    if mouse_x != @mouse_pos_x or mouse_y != @mouse_pos_y then
      mouse_move
    end
  end

  def mouse_move
    event = MouseEvent.new mouse_x, mouse_y, nil
    
    @ui.each do |elem|
      unless elem.within_clickable?(@mouse_pos_x, @mouse_pos_y)
        if elem.within_clickable?(event.x, event.y)
          elem.mouse_in(event)
        end
      end
      
      if elem.within_clickable?(@mouse_pos_x, @mouse_pos_y)
        unless elem.within_clickable?(event.x, event.y)
          elem.mouse_out(event)
        end
      end
    end
    
    @mouse_pos_x, @mouse_pos_y = event.x, event.y
  end


  def button_down(id)
    event = MouseEvent.new mouse_x, mouse_y, id
    
    @ui.each do |elem|
      elem.clicked(event) if elem.within_clickable?(event.x, event.y)
    end
  end
  
  def button_up(id)
    event = MouseEvent.new mouse_x, mouse_y, id
    
    @ui.each do |elem|
      elem.unclicked(event) if elem.within_clickable?(event.x, event.y)
    end
  end

  def draw_gui
    
    # Draw the "info" menu background
    @info_bar_bg.draw(0, 0, ZOrder::Background)
    @purchase_bar_bg.draw(0, 518, ZOrder::Background)
    @ui.each do |elem|
      elem.draw
    end

  end
  
end