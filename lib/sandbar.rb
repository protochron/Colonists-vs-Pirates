require File.dirname(__FILE__) + '/game_object'

class Sandbar < GameObject
    attr_accessor :health

    def initialize
        @health = 10
    end
end
