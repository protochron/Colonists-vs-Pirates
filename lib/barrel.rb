require File.dirname(__FILE__) + "/game_object"

# Barrel that covers a ship in oil. 
# Allows for some interesting strategies with FireCannons
class Barrel < GameObject

    attr_accessor :health, :cost
    def initialize(x,y)
        @x, @y = x, y
        @health = 100
        @cost = 30
    end

    # Detonate if a ship is in an adjacent tile
    def tick
        $window.ships.each do |s|
            if @x - s.x >= -100 #100 because it's x corresponds to the right-hand edge
                s.oil = true
                @health = 0
            end
        end
    end

end
