# This is the main driver. Code will follow shortly.
#

require 'gosu'
require 'optparse'


class GameWindow < Gosu::Window
    def initialize
        super(800,600, false)
        self.caption = "Colonists vs. Pirates!"
        @font = Gosu::Font.new(self, Gosu::default_font_name, 10)
    end

    def update
    end

    def draw
    end
end

# Actully draw our window
window = GameWindow.new
window.show
