require File.dirname(__FILE__) + '/game_object'
# Implements a basic Ship object. This is the simple enemy unit of the game.
class Ship < GameObject

    attr_accessor :health

    def initialize(x, y, image, health = 100)
        super(x, y, image)
        @health = health
    end

    # Shoot a cannonball straight ahead
    def shoot
    end
end
