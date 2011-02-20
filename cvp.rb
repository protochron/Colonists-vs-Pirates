# This is the main driver. Code will follow shortly.
#

require 'gosu'
require 'optparse'

module ZOrder
    Background, UI, Enemy, Player = *0..3
end


class GameWindow < Gosu::Window
    def initialize
        super(800,600, false)
        self.caption = "Colonists vs. Pirates!"
        @font = Gosu::Font.new(self, Gosu::default_font_name, 10)
        @background = Gosu::Image.new(self, "images/background.png")
    end

    def update
    end

    def draw
        @background.draw(0,0, ZOrder::Background, 1.0, 1.0)
    end
end

# Actully draw our window
window = GameWindow.new
window.show
