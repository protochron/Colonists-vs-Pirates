#
# Dan Norris and Cody Miller, 2011

require File.dirname(__FILE__) + '/game_object'

class Sandbar < GameObject
    attr_accessor :health
    attr_reader :cost
    
    def initialize(x, y)
        @x, @y = x, y
        @health = 70 
        @cost = 40
    end
end
