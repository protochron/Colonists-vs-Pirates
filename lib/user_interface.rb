# This is the module that provides all the UserInterface methods.
# Its main purpose is to keep the GameWindow class as clean as possible.

%w{button purchase_button close_button interface_state sell_button}.each do |file|
  require File.dirname(__FILE__) + '/' + file
end


module UserInterface

  def initialize(*params)
    super(*params)
    
    @state = InterfaceState.new
    @mouse_pos_x, @mouse_pos_y = 0,0
    
    exit = Gosu::Image.new(self, "images/exit.png")
    sell = Gosu::Image.new(self, "images/purchase.png")
    cannon_reg = Gosu::Image.new(self, "images/cannon_reg.png")
    cannon_fire = Gosu::Image.new(self, "images/cannon_fire.png")
    barrel = Gosu::Image.new(self, "images/barrel.png")
    sandbar = Gosu::Image.new(self, "images/sandbar_icon.png")
    
    @money_bar = Gosu::Image.new(self, "images/money_amount.png")
    @info_bar_bg = Gosu::Image.new(self, "images/info_menu_background.png")
    @purchase_bar_bg = Gosu::Image.new(self, 
                                      "images/purchase_menu_background.png")

    regcan_but = PurchaseButton.new(40, 
      525, 
      ZOrder::UI, 
      cannon_reg, 
      self).
      cost(15).
      mode([:Cannon, cannon_reg])

    firecan_but = PurchaseButton.new(140, 
      525, 
      ZOrder::UI, 
      cannon_fire, 
      self).
      cost(45).
      mode([:FireCannon, cannon_fire])

    sandbar_but = PurchaseButton.new(340, 
      525, 
      ZOrder::UI, 
      sandbar, 
      self).
      cost(40).
      mode([:Sandbar, Gosu::Image.new(self, "images/sandbarge.png")])

    barrel_but = PurchaseButton.new(240, 
      525, 
      ZOrder::UI, 
      barrel, 
      self).
      cost(30).
      mode([:Barrel, barrel])

    @ui = CloseButton.new(725, 0, ZOrder::UI, exit),
          SellButton.new(675, 0, ZOrder::UI, sell),
          regcan_but,
          firecan_but,
          sandbar_but,
          barrel_but

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
    event = MouseEvent.new mouse_x, mouse_y, nil, @window, @state
    
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

  def draw_money
    @font.draw($money.to_s, 60, 16, ZOrder::UI)
  end

  def button_down(id)
    event = MouseEvent.new mouse_x, mouse_y, id, @window, @state
    
    @ui.each do |elem|
      elem.clicked(event) if elem.within_clickable?(event.x, event.y)
    end
  end
  
  def button_up(id)
    event = MouseEvent.new mouse_x, mouse_y, id, @window, @state
    
    @ui.each do |elem|
      elem.unclicked(event) if elem.within_clickable?(event.x, event.y)
    end
    
    unless @tiles.nil? then
      @tiles.each do |elem|
        elem.unclicked(event) if elem.within_clickable?(event.x, event.y)
      end
    end
    
  end

  def draw_gui
    
    # Draw the "info" menu
    @info_bar_bg.draw(0, 0, ZOrder::UI)
    @purchase_bar_bg.draw(0, 518, ZOrder::UI)
    @money_bar.draw(10, 3, ZOrder::UI, 1.0, 1.0)
    
    @ui.each do |elem|
      elem.draw
    end

    draw_money

  end
  
end
