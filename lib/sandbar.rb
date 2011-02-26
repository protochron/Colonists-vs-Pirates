require File.dirname(__FILE__) + '/game_object'

class Sandbar < GameObject
    attr_accessor :health
    attr_reader :cost
    
    def initialize
        @health = 10
        @cost = 40
    end
end
