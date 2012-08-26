package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import data.GeneratedValue;
import data.Genome;
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
		if (m_genomes != null)
		{
			if (now > m_nextSpawn && m_genomes.length > 0)
			{
				m_nextSpawn = Date.fromTime(now + Interval.get()).getTime();
				
				var spawnedEnemy : Enemy = new Enemy(this, m_genomes.pop(), m_cellSize);
				spawnedEnemy.follow(Paths[Math.floor(Math.random() * Paths.length)]);
				
				HXP.world.add(spawnedEnemy);
			}
		}
	}
	
	public function reclaim(enemy : Enemy)
	{
		m_reclaimed.push(enemy.Genes);
	}
	
	private function createGenome() : Genome { return new Genome(Life, Speed, Armor); }
	private function createPool(minSize : Int) : Array<Genome>
	{
		var pool : Array<Genome> = new Array<Genome>();
		
		if (m_reclaimed != null)
		{
			for (left in 0...m_reclaimed.length)
				for (right in (left + 1)...m_reclaimed.length)
					pool.push(Genome.cross(m_reclaimed[left], m_reclaimed[right]));
		}
		
		while (pool.length < minSize) pool.push(createGenome());
		
		return pool;
	}
	public function breed(amount : Int)
	{
		m_genomes = new Array<Genome>();
		
		var pool : Array<Genome> = createPool(amount);
		
		for (counter in 0...amount)
		{
			var index : Int = Math.floor(Math.random() * pool.length);
			m_genomes.push(pool[index]);
		}
		
		m_reclaimed = new Array<Genome>();
	}
	
	public function getSurvivorsCount() : Int
	{
		if (m_reclaimed != null) return m_reclaimed.length;
		return 0;
	}
	
	private var m_genomes : Array<Genome>;
	private var m_reclaimed : Array<Genome>;
	
	private var m_cellSize : Int;
	private var m_nextSpawn : Float;
	
	public var Life : GeneratedValue;
	public var Speed : GeneratedValue;
	public var Armor : GeneratedValue;
	public var Interval : GeneratedValue;
	
	public var Paths : Array<Path>;
}