require File.dirname(__FILE__) + '/game_object'
require File.dirname(__FILE__) + '/projectile'

# Implements a cannon object. This is a basic defensive structure for the player to destroy enemy ships with.
class Cannon < GameObject
    @shoot_interval = 7 * 60
    attr_accessor :health, :projectiles

    def initialize
        @health = 50
        @projectiles = []
        @tick_counter = 0
    end

    # Action to take every window update.
    def tick
        @tick_counter += 1
        if @tick_counter > @shoot_interval 
            shoot
            @tick_counter = 0
        end
    end

    # Shoot a projectile at a ship
    def shoot
        if !@projectiles.empty?
            @projectiles.each do |p|
            end
        end
    end
end
