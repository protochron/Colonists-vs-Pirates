# This is the main driver. Code will follow shortly.
#

require 'gosu'
require 'optparse'
require './lib/ship'

module ZOrder
    Background, UI, Enemy, Player = *0..3
end


class GameWindow < Gosu::Window
    def initialize
        super(800,600, false)
        self.caption = "Colonists vs. Pirates!"
        @font = Gosu::Font.new(self, Gosu::default_font_name, 10)

        # Image elements
        @background = Gosu::Image.new(self, "images/background.png")
        @ship = Gosu::Image.new(self, "images/fast_boat.png")
        @money_bar = Gosu::Image.new(self, "images/money_amount.png")
        @exit = Gosu::Image.new(self, "images/exit.png")
        @cannon_fire = Gosu::Image.new(self, "images/canon_fire.png")
        @cannon_reg = Gosu::Image.new(self, "images/canon_reg.png")
        @purchase = Gosu::Image.new(self, "images/purchase.png")

        @enemy_ships = []

        # For testing
        @enemy_ships << Ship.new(800, 325, @ship)
    end


    def update
        if button_down? Gosu::Button::KbQ or button_down? Gosu::Button::KbEscape
            close
        end

        @enemy_ships.each{|s| s.tick}
    end

    def draw
        #Background and UI draw
        @background.draw(0,0, ZOrder::Background, 1.0, 1.0)

        @money_bar.draw(10, 0, ZOrder::Background, 1.0, 1.0)
        @purchase.draw(500, 0, ZOrder::Background, 1.0, 1.0)
        @exit.draw(600, 0, ZOrder::Background, 1.0, 1.0)
        @cannon_fire.draw(40, 500, ZOrder::Background, 1.0, 1.0)
        @cannon_reg.draw(120, 500, ZOrder::Background, 1.0, 1.0)

        # Call individual object draw methods
        @enemy_ships.each{|s| s.image.draw(s.x, s.y, ZOrder::Enemy, 1.0,1.0)}

    end
end

# Actully draw our window
window = GameWindow.new
window.show
