# This is the main driver. Code will follow shortly.
#

require 'gosu'
require 'optparse'
require './lib/ship'
require './lib/button'
require './lib/user_interface'

module ZOrder
    Background, UI, Enemy, Player = *0..3
end

$window_x = 800
$window_y = 600

class GameWindow < Gosu::Window
    include UserInterface
    
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
        @cannon_fire = Gosu::Image.new(self, "images/canon_fire.png")
        @cannon_reg = Gosu::Image.new(self, "images/canon_reg.png")

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

        mouse_update
        
        @ships.each{|s| s.tick}
    end
    
    def needs_cursor?
      return true
    end

    def draw
        #Background and UI draw
        @background.draw(0,0, ZOrder::Background, 1.0, 1.0)

        @money_bar.draw(10, 0, ZOrder::Background, 1.0, 1.0)
        #@purchase.draw(500, 0, ZOrder::Background, 1.0, 1.0)
        #@exit.draw(600, 0, ZOrder::Background, 1.0, 1.0)
        @cannon_fire.draw(40, 500, ZOrder::Background, 1.0, 1.0)
        @cannon_reg.draw(120, 500, ZOrder::Background, 1.0, 1.0)

        draw_gui

        # Call individual object draw methods
        @ships.each{ |s| s.image.draw(s.x, s.y, ZOrder::Enemy, 1.0,1.0) }

    end
end

# Actully draw our window
$window = GameWindow.new
$window.set_mouse_position(0,0)
$window.show
