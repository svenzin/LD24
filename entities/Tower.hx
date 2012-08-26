package entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Tower extends Entity
{

	public function new(x : Float, y : Float, cellSize : Int) 
	{
		super(x, y);
		
		graphic = makeInstanceGraphic(cellSize);
		
		setHitbox(cellSize, cellSize);
		
		m_nextShot = Date.now().getTime();
		
		m_rangeBox = new Box(0);
		HXP.world.add(m_rangeBox);
		
		m_cellSize = cellSize;
		
		type = "Tower";
		
		setup(0, 4, 0, 0);
	}
	
	public function makeInstanceGraphic(cellSize : Int) : Graphic
	{
		return Tower.makeGraphic(cellSize);
	}
	
	public static function makeGraphic(cellSize : Int) : Graphic
	{
		var delta = Math.floor(0.2 * cellSize);
		var image : Image = Image.createRect(cellSize - 2 * delta, cellSize - 2 * delta, 0xA0A0A0);
		image.x = delta;
		image.y = delta;
		return image;
	}
	
	public function setup(theRange : Float, theDamage : Float, theSpeed : Float, thePierce : Float)
	{
		Range = theRange;
		Damage = theDamage;
		Speed = theSpeed;
		Pierce = thePierce;
		
		m_rangeBox.setRange(Math.floor(32 * Range));
	}
	
	public function teardown()
	{
		HXP.world.remove(m_rangeBox);
	}
	
	public override function update()
	{
		shoot();
		
		super.update();
	}
	
	private function shoot()
	{
		var now : Float = Date.now().getTime();
		if (now >= m_nextShot)
		{
			var targets : Array<Entity> = new Array<Entity>();
			m_rangeBox.collideInto("Enemy", x + halfWidth - m_rangeBox.halfWidth, y + halfHeight - m_rangeBox.halfHeight, targets);
			if (targets.length > 0)
			{
				m_nextShot = now + Speed;
				
				var bullet : Bullet = new Bullet(this, targets[Math.floor(Math.random() * targets.length)]);
				bullet.setup(5, Damage, Pierce);
			}
		}
	}

	public var Range : Float;
	public var Damage : Float;
	public var Speed : Float;
	public var Pierce : Float;
	
	private var m_nextShot : Float;
	private var m_rangeBox : Box;
	private var m_cellSize : Int;
}