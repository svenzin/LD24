package worlds;

import com.haxepunk.Entity;
import com.haxepunk.World;
import com.haxepunk.graphics.Image;
import data.Path;
import entities.Ant;
import entities.AntSource;
import entities.Display;
import entities.HQ;
import entities.Cell;
import entities.Map;
import entities.Tower;

import entities.Block;
import entities.Player;
import entities.Enemy;

class GameWorld extends World
{

	public function new() 
	{
		super();
		
		cycle = 0;
	}
	
	public override function begin()
	{
		add(new Display());
		
		m_hqs = new Array<HQ>();
		m_hqs.push(new HQ(Cell.SIZE * 1, Cell.SIZE * 2));
		m_hqs[0].setup(0);
		
		map = new Map(20, 10);
		map.set(1, 2, m_hqs[0]);
		
		add(map);
	}
	
	public override function update()
	{
		cycle++;
		if (cycle % cycleLength == 0)
		{
			for (hq in m_hqs)
			{
				hq.createWorker();
			}
			
			cycle = 0;
		}
		
		super.update();
	}
	
	public static var cycleLength : Int = 200;
	public var cycle : Int;
	
	public var m_hqs : Array<HQ>;
	
	public var map(default, null) : Map;
}
