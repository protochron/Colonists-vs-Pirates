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

    def tick
    end


end
