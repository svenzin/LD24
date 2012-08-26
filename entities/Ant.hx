package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import data.Path;
import data.WayPoint;

class Ant extends Entity
{
	public static var MAXIMUM_SIZE  : Int = 32;
	public static var MAXIMUM_SPEED : Float = 10;

	public function new() 
	{
		super();
		
		count++;
	}
	
	public function setup(x : Float, y : Float, life : Float, speed : Float, armor : Float)
	{
		var size  : Int = Math.floor(life * MAXIMUM_SIZE);
		
		var red   : Int = Math.floor(0xFF * life);
		var green : Int = Math.floor(0xFF * speed);
		var blue  : Int = Math.floor(0xFF * armor);
		var color : Int = 0x010000 * red + 0x000100 * green + 0x000001 * blue;
		
		
		graphic = Image.createRect(size, size, color);
		setHitbox(size, size);
		
		m_life = life;
		m_armor = armor;
		m_speed = MAXIMUM_SPEED * speed;
		
		moveTo(x, y);
	}
	
	public function follow(path : Path, tower : Tower)
	{
		if (path != null)
		{
			m_tower = tower;
			
			start();
			
			m_pathIterator = path.waypoints.iterator();
			moveToNext();
		}
		
	}
	
	private function moveToNext()
	{
		if (m_pathIterator.hasNext())
		{
			m_moveTo = m_pathIterator.next();
		}
		else
		{
			stop();
			//m_tower.reach(this);
		}
	}
	public function start() { m_moving = true;  }
	public function stop()  { m_moving = false; }
	
	public override function update()
	{
		if (m_moving)
		{
			var distance : Float = distanceToPoint(m_moveTo.x, m_moveTo.y);
			if (distance < 10)
			{
				moveToNext();
			}
			else
			{
				moveTowards(m_moveTo.x, m_moveTo.y, m_speed);
			}
		}
	}

	public static var count : Int = 0;
	
	private var m_moving : Bool;
	private var m_pathIterator : Iterator<WayPoint>;
	private var m_moveTo : WayPoint;
	private var m_tower : Tower;
	
	private var m_life : Float;
	private var m_speed : Float;
	private var m_armor : Float;
}