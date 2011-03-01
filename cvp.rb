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
    Background, Enemy, Player, UI = *0..3
end

$window_x = 800
$window_y = 600
$money = 100

class GameWindow < Gosu::Window
    include UserInterface
    
    attr_reader :cannon_ball, :tiles, :ships, :level, :num_ships
    
    def initialize
        super($window_x, $window_y, false)
        self.caption = "Colonists vs. Pirates!"
        @font = Gosu::Font.new(self, Gosu::default_font_name, 10)
        #@mouse_pos_x, @mouse_pos_y = 0,0
        
        set_window_ref_for_gui(self)

        # Image elements
        @background = Gosu::Image.new(self, "images/background.png")
        @ship = Gosu::Image.new(self, "images/fast_boat.png")
        @fire_ship = Gosu::Image.new(self, "images/fast_boat_fire.png")
        @cannon_ball = Gosu::Image.new(self, "images/cannon_ball.png")
        @game_over_font = Gosu::Font.new(@window, "Arial", 40)
        @game_over = Gosu::Image.from_text(self, "Game Over", @game_over_font, 40, 40, $window_x / 3, :center)
        @regular_font = Gosu::Font.new(self, "Arial", 20)

        @level = 1
        @levels = File.open("levels.txt", 'r').readlines.map!{|l| l.chomp!.to_i}
        @level_text = Gosu::Image.from_text(self, "Level #{level}", @regular_font, 20, 40, $window_x / 3, :left)

        # Object collections
        @ships = []
        @num_ships = @levels.shift
        @ships_to_deploy = @num_ships
        @delay = 5 * 60

        @ship_text = Gosu::Image.from_text(self, "Ships remaining: #{@num_ships}", @regular_font, 20, 40, $window_x / 3, :left)

        # Map tile collections
        @tiles = build_tile_maps()

        # For testing
        #@ships << Ship.new(800, 330, @ship)

        # counters
        @money_counter = 0
        @deploy_counter = 0
        @level_timer = 0
        @switch = false
        @draw_switch = true

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

        # Special case updates
        if @switch
            switch_level
            @switch = false
            @draw_switch = true
            return
        elsif @draw_switch
            @level_timer += 1
            return
        end

        @money_counter += 1
        @deploy_counter += 1

        if @money_counter >= 60
            @money_counter = 0
            $money += 1
        end

        if @deploy_counter >= @delay and @ships_to_deploy > 0
            @ships << Ship.new(800, rand(5) * 100 + 30, @ship, @fire_ship) 
            @ships_to_deploy -= 1
            @deploy_counter = 0
        end
        # Determine if the mouse moved. Send the message to the correct places.
        mouse_update
        
        # Call tick methods if applicable.
        @ships.each{|s| s.tick}
        @tiles.each do |t|
            if !t.content.nil?
                t.content.tick if t.content.respond_to?('tick')
            end
        end


        # Delete a ship if it's health is < 1.
        @ships.each do |s|
            if s.health < 1
                @ships.delete(s)
                @num_ships -= 1
                @ship_text = Gosu::Image.from_text(self, "Ships remaining: #{@num_ships}", @regular_font, 20, 40, $window_x / 3, :left)
            end
            if @num_ships == 0
                @switch = true 
            end
        end
    end
    
    def needs_cursor?
      return true
    end

    # Clean up code for levels
    def switch_level
        @ships.clear if @ships.size != 0
        @tiles.each {|t| t.content = nil; t.image = nil}
        @level += 1
        @num_ships = @ships_to_deploy = @levels.shift
        @switch = false
        $money = 100 + 20 * @level 
        @level_text = Gosu::Image.from_text(self, "Level #{@level}", @regular_font, 20, 40, 400, :left)
        @ship_text = Gosu::Image.from_text(self, "Ships remaining: #{@num_ships}", @regular_font, 20, 40, $window_x / 3, :left)
    end

    # Main draw method
    def draw
        if $money <= 0
            @game_over.draw($window_x / 3, $window_y / 2, ZOrder::UI, 1.0, 1.0)
            @background.draw(0,0, ZOrder::Background, 1.0, 1.0)
            return
        end

        #Background and UI draw
        @background.draw(0,0, ZOrder::Background, 1.0, 1.0)

        if @draw_switch
            Gosu::Image.from_text(self, "Level #{@level}", @game_over_font, 40, 40, 300, :center).draw($window_x / 3, $window_y / 2, ZOrder::UI, 1.0, 1.0)
            if @level_timer >= 180 
                @draw_switch = false 
                @level_timer = 0
            end
            return
        end

        # Draw elements that are part of the GUI.
        draw_gui

        # Draw level text and num ships remaining
        # (Easier to do in this file)
        @level_text.draw(300, 15, ZOrder::UI)
        @ship_text.draw(400, 15, ZOrder::UI)

        # Call ship object draw methods
        @ships.each do |s|
            if s.landed?
                @ships.delete(s)
                $money -= 30
            else
                s.image.draw(s.x, s.y, ZOrder::Enemy, 1.0,1.0)
                s.projectiles.each{|p| p.image.draw(p.x, p.y, ZOrder::Enemy, 1.0, 1.0)}
            end
        end

        # Draw the individual tiles and anything that may be on them
        @tiles.each do |t| 
            t.draw 
            if t.content.class != NilClass
                if t.content.health < 1
                    t.content = nil
                    t.image = nil
                end
            end
            if t.content.respond_to?(:projectiles)
                t.content.projectiles.each{|p| p.image.draw(p.x, p.y, ZOrder::Player, 1.0, 1.0)}
            end
        end
    end
end

# Actully draw our window
$window = GameWindow.new
$window.set_mouse_position(0,0)
$window.show
