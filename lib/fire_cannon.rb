#
# Dan Norris and Cody Miller, 2011

require File.dirname(__FILE__) + "/game_object"
%w{cannon}.each do |file|
    require File.dirname(__FILE__) + '/' + file
end


# A fire cannon will set ships on fire if they are covered in oil, otherwise they do slightly more damage than a normal cannon.
class FireCannon < Cannon 
    def initialize(x,y)
        super(x,y)
        @cost = 45
        @fire_damage = 0.3
        @health = 70
        @projectile_damage = 20
    end

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
                    if p.x - s.x >= 1 and p.y - s.y < 100
                        s.health -= p.damage
                        s.on_fire = @fire_damage if s.oil? and s.on_fire == 0
                        @projectiles.delete(p)
                        next
                    end
                end
            end
        end
    end

    # Shoot a projectile at a ship
    def shoot
        @projectiles << Projectile.new(@x + 55, @y + 20, $window.fire_ball, @projectile_damage, 0.3, :right) 
    end
end
