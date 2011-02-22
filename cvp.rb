# This is the main driver. Code will follow shortly.
#

if RUBY_VERSION == "1.8.7"
    require 'rubygems'
end
require 'gosu'
require 'optparse'

%w{ship user_interface tile}.each do |fname|
  require File.dirname(__FILE__) + '/lib/' + fname
end

module ZOrder
    Background, UI, Enemy, Player = *0..3
end

$window_x = 800
$window_y = 600

class GameWindow < Gosu::Window
    include UserInterface
    
    attr_reader :cannon_ball
    
    def initialize
        super($window_x, $window_y, false)
        self.caption = "Colonists vs. Pirates!"
        @font = Gosu::Font.new(self, Gosu::default_font_name, 10)
        @mouse_pos_x, @mouse_pos_y = 0,0
        
        set_window_ref_for_gui(self)

        # Image elements
        @background = Gosu::Image.new(self, "images/background.png")
        @ship = Gosu::Image.new(self, "images/fast_boat.png")
        @cannon_ball = Gosu::Image.new(self, "images/cannon_ball.png")

        # Object collections
        @ships = []

        # Map tile collections
        @tiles = build_tile_maps()

        # For testing
        @ships << Ship.new(800, 330, @ship)

    end

    def build_tile_maps
      tiles = []
      (0..6).to_a.each do |x|
        (0..4).to_a.each do |y|
          tiles << Tile.new(x*100+138, y*100+20, 100, 100)
        end
      end
      
      tiles
    end

    def update
        if button_down? Gosu::Button::KbQ or button_down? Gosu::Button::KbEscape
            close
        end

        # Determine if the mouse moved. Send the message to the correct places.
        mouse_update
        
        @ships.each{|s| s.tick}
    end
    
    def needs_cursor?
      return true
    end

    def draw
        #Background and UI draw
        @background.draw(0,0, ZOrder::Background, 1.0, 1.0)

        # Draw the individual tiles and anything that may be on them
        @tiles.each { |t| t.draw }

        # Draw elements that are part of the GUI.
        draw_gui


        # Call individual object draw methods
        @ships.each do |s|
             s.image.draw(s.x, s.y, ZOrder::Enemy, 1.0,1.0)
             s.projectiles.each{|p| p.image.draw(p.x, p.y, ZOrder::Enemy, 1.0, 1.0)}
        end

    end
end

# Actully draw our window
$window = GameWindow.new
$window.set_mouse_position(0,0)
$window.show
