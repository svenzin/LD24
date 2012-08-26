package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import data.GeneratedValue;
import data.Path;
import flash.sampler.NewObjectSample;

class Nest extends Entity
{

	public function new(x : Int, y : Int, cellSize : Int) 
	{
		super(x, y);
		
		var delta : Int = Math.floor(0.1 * cellSize);
		var image : Image = Image.createRect(cellSize - 2 * delta, cellSize - 2 * delta, 0xA00000);
		image.x = delta;
		image.y = delta;
		setGraphic(image);
		
		m_cellSize = cellSize;
		m_nextSpawn = Date.now().getTime();
	}
	
	public override function update()
	{
		spawn();
		super.update();
	}
	
	public function spawn()
	{
		var now : Float = Date.now().getTime();
		if (now > m_nextSpawn)
		{
			m_nextSpawn = Date.fromTime(now + Interval.get()).getTime();
			
			var spawnedEnemy : Enemy = new Enemy(this, Life.get(), Speed.get(), Armor.get(), m_cellSize);
			spawnedEnemy.follow(Paths[Math.floor(Math.random() * Paths.length)]);
			
			HXP.world.add(spawnedEnemy);
		}
	}
	
	public function reclaim(enemy : Enemy)
	{
		Life.accumulate(enemy.Life);
		Speed.accumulate(enemy.Speed);
		Armor.accumulate(enemy.Armor);
	}
	
	private var m_cellSize : Int;
	private var m_nextSpawn : Float;
	
	public var Life : GeneratedValue;
	public var Speed : GeneratedValue;
	public var Armor : GeneratedValue;
	public var Interval : GeneratedValue;
	
	public var Paths : Array<Path>;
}