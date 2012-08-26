package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import data.Path;
import data.WayPoint;

class Enemy extends Entity
{
	public static var maxLife  : Float = 1;
	public static var maxSpeed : Float = 1;
	public static var maxArmor : Float = 1;
	
	public function new(nest : Nest, theLife : Float, theSpeed : Float, theArmor : Float, cellSize : Int) 
	{
		super();
		
		Life = theLife;
		Speed = theSpeed;
		Armor = theArmor;
		
		m_life = Life;
		m_nest = nest;
		
		var maxSize : Int = Math.floor(cellSize / 2);
		var size  : Int = Math.floor(Math.max(2, (maxSize - 2) * Life / maxLife));
		var color : Int = Math.floor(0xFFFF00 * Armor / maxArmor);
		graphic = Image.createRect(size, size, color);
		setHitbox(size, size);
		
		type = "Enemy";
	}
	
	public function follow(path : Path)
	{
		m_path = path.waypoints.iterator();
		m_target = m_path.next();
		moveTo(m_target.x, m_target.y);
	}
	
	public function move()
	{
		if (distanceToPoint(m_target.x, m_target.y) < Speed)
		{
			if (m_path.hasNext())
			{
				m_target = m_path.next();
			}
			else
			{
				win();
			}
		}
		else
		{
			moveTowards(m_target.x, m_target.y, Speed);
		}
	}
	
	public function die()
	{
		active = false;
		HXP.world.remove(this);
	}
	
	public function win()
	{
		m_nest.reclaim(this);
		die();
	}
	
	public function hit(bullet : Bullet)
	{
		m_life -= Math.max(0, bullet.Damage - Math.max(0, Armor - bullet.Pierce));
		
		if (m_life <= 0)
		{
			die();
		}
	}
	
	public override function update()
	{
		move();
		
		super.update();
	}
	
	public var Life : Float;
	public var Speed : Float;
	public var Armor : Float;

	private var m_life : Float;
	private var m_target : WayPoint;
	private var m_path : Iterator<WayPoint>;
	private var m_nest : Nest;
}