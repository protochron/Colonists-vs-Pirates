require File.dirname(__FILE__) + '/game_object'
# Defines how a projectile moves along with collision detection.
class Projectile < GameObject

    attr_reader :damage, :direction

    def initialize(x, y, image, damage, speed, dir)
        super(x, y, image)
        @damage = damage
        @speed = speed
        @direction = dir
    end

    # Basic code for hit detection.
    # TODO: Test if this works. Ported from Pirate Duel game, so things might be different here.
    def hit?(target)
        if @direction == :right
            if target.x - (@image.width + @x) < -1
                return true
            end
        else
            # Reverse for opposite direction
            if (target.x + target.image.width) - @x > 1
                return true
            end
        end
        return false
    end


    def tick
        if @dir == :left
            @x -= @speed
        else
            @x += @speed
        end
    end

    def outside_bounds?
        super
    end

end
