require File.dirname(__FILE__) + '/game_object'
require File.dirname(__FILE__) + '/projectile'

# Implements a basic Ship object. This is the simple enemy unit of the game.
class Ship < GameObject
    @@speed = 0.1 #Controls movement speed for ships
    @@shoot_interval = 3 * 60 
    attr_accessor :health, :projectiles

    def initialize(x, y, image, health = 100)
        super(x, y, image)
        @health = health
        @tick_counter = 0
        @projectiles = []
        @delay = 3 * 60
    end

    # Actions to take every window update
    def tick
        @x -= 0.1
        @tick_counter += 1

        #Puts a delay on shooting
        if @delay > 0
            @delay -= 1
        end

        @projectiles.each do |p|
            p.tick
            if p.outside_bounds?
                @projectiles.delete(p)
            end
        end

        if @tick_counter >= @@shoot_interval and @delay < 1
            shoot
            @tick_counter = 0
        end
    end

    # Shoot a cannonball straight ahead
    def shoot
        @projectiles << Projectile.new(@x, @y, $window.cannon_ball, 10, 0.3, :left) 
    end

end
