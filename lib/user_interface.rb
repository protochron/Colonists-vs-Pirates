# This is the module that provides all the UserInterface methods.
# Its main purpose is to keep the GameWindow class as clean as possible.

module UserInterface

  def initialize(*params)
    super(*params)
    
    @mouse_pos_x, @mouse_pos_y = 0,0

    exit = Gosu::Image.new(self, "images/exit.png")
    purchase = Gosu::Image.new(self, "images/purchase.png")

    @info_bar_bg = Gosu::Image.new(self, "images/info_menu_background.png")

    @ui = Button.new(725, 0, ZOrder::Background, exit),
          Button.new(675, 0, ZOrder::Background, purchase)

  end
  
  def set_window_ref_for_gui(window)
    @window = window
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
    
    @ui.each do |elem|
      elem.draw
    end
  end
  
end