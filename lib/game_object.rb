# Implements basic attributes common between all game objects.
# Game objects are all objects (other than GUI components) that the player interacts with.
class GameObject
    attr_reader :image
    attr_accessor :x, :y

    def initialize(x, y, image)
        @x = x
        @y = y
        @image = image
    end

    # For moving an object in one command
    def move(x, y)
        @x = x
        @y = y
    end

    # Action to take each tick.
    # Each subclass should implement their own.
    def tick
    end

    # For self-testing bounds checking
    def outside_bounds?
        if @x < 0 or @x > $window_x or @y < 0 or @y > $window_y
            return true
        end
    end


end
