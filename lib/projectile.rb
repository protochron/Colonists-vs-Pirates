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
    def hit
        hit_object = $window.tiles.select{|t| t.within_clickable?(@x, @y) and !t.content.nil?}
        return hit_object.first if !hit_object.nil?
    end


    def tick
        if @direction == :left
            @x -= @speed
        else
            @x += @speed
        end
    end

    def outside_bounds?
        super
    end

end
