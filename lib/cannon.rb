require File.dirname(__FILE__) + '/game_object'
require File.dirname(__FILE__) + '/projectile'

# Implements a cannon object. This is a basic defensive structure for the player to destroy enemy ships with.
class Cannon < GameObject
    attr_accessor :health, :projectiles
    attr_reader :cost

    def initialize(x,y)
        @x, @y = x, y
        @health = 50
        @projectiles = []
        @tick_counter = 0
        @shoot_interval = 7 * 60
        @cost = 15
    end
    
    # Action to take every window update.
    def tick
        @tick_counter += 1
        if @tick_counter >= @shoot_interval
            shoot
            @tick_counter = 0
        end

        if !@projectiles.empty?
            @projectiles.each do |p|
                p.tick
                # Iterate over ships until we find one that intersects.
                $window.ships.each do |s|
                    if p.x - s.x >= 1
                        s.health -= p.damage
                        @projectiles.delete(p)
                        next
                    end
                end
            end
        end
    end

    # Shoot a projectile at a ship
    def shoot
        @projectiles << Projectile.new(@x + 55, @y + 20, $window.cannon_ball, 10, 0.3, :right) 
    end
end
