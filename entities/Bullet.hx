package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Bullet extends Entity
{

	public function new(source : Entity, target : Entity) 
	{
		super(source.x + source.halfWidth, source.y + source.halfHeight);
		
		graphic = Image.createRect(2, 2, 0xFFFFFF);
		setHitbox(2, 2);
		
		HXP.world.add(this);
		Target = cast(target, Enemy);
	}
	
	public function setup(speed : Float, damage : Float, pierce : Float)
	{
		Speed = speed;
		Damage = damage;
		Pierce = pierce;
	}
	
	public override function update()
	{
		if (!die())
		{
			move();
			hit();
		}
		
		super.update();
	}
	
	private function move()
	{
		moveTowards(Target.x, Target.y, Speed);
	}
	
	private function hit()
	{
		if (collideWith(Target, x, y) != null)
		{
			HXP.world.remove(this);
			Target.hit(this);
		}
	}
	
	private function die()
	{
		if (!Target.active)
		{
			HXP.world.remove(this);
			return true;
		}
		return false;
	}
	
	public var Target : Enemy;
	
	public var Speed : Float;
	public var Damage : Float;
	public var Pierce : Float;
}