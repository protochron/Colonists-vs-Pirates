# This is the main driver. Code will follow shortly.
#

require 'gosu'
require 'optparse'
require './lib/ship'
require './lib/button'

module ZOrder
    Background, UI, Enemy, Player = *0..3
end

$window_x = 800
$window_y = 600
class GameWindow < Gosu::Window
    attr_reader :cannon_ball
    def initialize
        super($window_x,$window_y, false)
        self.caption = "Colonists vs. Pirates!"
        @font = Gosu::Font.new(self, Gosu::default_font_name, 10)
        @mouse_pos_x, @mouse_pos_y = 0,0
        
        # Image elements
        @background = Gosu::Image.new(self, "images/background.png")
        @ship = Gosu::Image.new(self, "images/fast_boat.png")
        @money_bar = Gosu::Image.new(self, "images/money_amount.png")
        exit = Gosu::Image.new(self, "images/exit.png")
        @cannon_fire = Gosu::Image.new(self, "images/canon_fire.png")
        @cannon_reg = Gosu::Image.new(self, "images/canon_reg.png")
        purchase = Gosu::Image.new(self, "images/purchase.png")

        #@exit_b = Button.new(600, 0, ZOrder::Background, exit)
        #@exit_b.clickable_area(600, 0, 650, 30)
        @ui = Button.new(725, 0, ZOrder::Background, exit),
              Button.new(675, 0, ZOrder::Background, purchase)
        @cannon_ball = Gosu::Image.new(self, "images/cannon_ball.png")

        # Object collections
        @ships = []

        # For testing
        @ships << Ship.new(800, 330, @ship)

    end


    def update
        if button_down? Gosu::Button::KbQ or button_down? Gosu::Button::KbEscape
            close
        end

        if mouse_x != @mouse_pos_x or mouse_y != @mouse_pos_y then
          mouse_move
        end
        
        @ships.each{|s| s.tick}
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
    
    def needs_cursor?
      return true
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


    def draw
        #Background and UI draw
        @background.draw(0,0, ZOrder::Background, 1.0, 1.0)

        @ui.each do |elem|
          elem.draw
        end


        @money_bar.draw(10, 0, ZOrder::Background, 1.0, 1.0)
        #@purchase.draw(500, 0, ZOrder::Background, 1.0, 1.0)
        #@exit.draw(600, 0, ZOrder::Background, 1.0, 1.0)
        @cannon_fire.draw(40, 500, ZOrder::Background, 1.0, 1.0)
        @cannon_reg.draw(120, 500, ZOrder::Background, 1.0, 1.0)

        # Call individual object draw methods
        @ships.each{ |s| s.image.draw(s.x, s.y, ZOrder::Enemy, 1.0,1.0) }

    end
end

# Actully draw our window
$window = GameWindow.new
$window.set_mouse_position(0,0)
$window.show
