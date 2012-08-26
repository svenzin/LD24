package worlds;

import entities.effects.Fader;
import com.haxepunk.World;
import data.GeneratedValue;
import data.Path;
import entities.DebugDisplay;
import entities.Display;
import entities.Enemy;
import entities.Goal;
import entities.DefenseLevel;
import entities.Nest;

class DefenseWorld extends World
{

	public function new() 
	{
		super();
	}
	
	private function buildPath(x : Array<Int>, y : Array<Int>) : Path
	{
		var path : Path = new Path();
		
		var size   : Int = m_cellSize;
		var offset : Int = Math.floor(m_cellSize / 2);
		for (index in 0...x.length)
		{
			path.append(x[index] * size + offset, y[index] * size + offset);
		}
		
		return path;
	}
	
	private function buildNest(x : Int, y : Int) : Nest
	{
		return new Nest(x * m_cellSize, y * m_cellSize, m_cellSize);
	}
	
	private function buildGoal(x : Int, y : Int) : Goal
	{
		return new Goal(x * m_cellSize, y * m_cellSize, m_cellSize);
	}
	
	public override function begin()
	{
		intro();
		worldBuild();
		super.begin();
	}
	
	private function worldBuild()
	{
		m_cellSize = 64;
		m_sizeX = 8;
		m_sizeY = 8;
		
		m_available = [
			0, 0, 1, 1, 1, 1, 1, 1,
			0, 0, 0, 0, 0, 1, 1, 1,
			1, 1, 1, 1, 0, 0, 1, 1,
			1, 1, 1, 1, 1, 0, 0, 1,
			1, 0, 0, 0, 1, 1, 0, 1,
			1, 0, 1, 0, 0, 0, 0, 1,
			1, 0, 0, 0, 0, 0, 0, 0,
			1, 1, 1, 1, 1, 1, 0, 0
		];
		
		m_type = [
			0, 0, 1, 1, 1, 1, 1, 1,
			0, 0, 0, 0, 0, 1, 1, 1,
			1, 1, 1, 1, 0, 0, 1, 1,
			1, 1, 1, 1, 1, 0, 0, 1,
			1, 0, 0, 0, 1, 1, 0, 1,
			1, 0, 1, 0, 0, 0, 0, 1,
			1, 0, 0, 0, 0, 0, 0, 0,
			1, 1, 1, 1, 1, 1, 0, 0
		];
		
		add(new DefenseLevel(m_type, m_available, m_sizeX, m_sizeY, m_cellSize));
		
		var path1 : Path = buildPath(
			[0, 2, 4, 4, 5, 5, 6, 6, 3, 3, 1],
			[0, 1, 1, 2, 2, 3, 3, 5, 5, 4, 4]
		);
		
		var path2 : Path = buildPath(
			[0, 2, 4, 4, 5, 5, 6, 6, 3, 1, 1],
			[0, 1, 1, 2, 2, 3, 3, 5, 6, 6, 4]
		);
		
		var path3 : Path = buildPath(
			[7, 6, 3, 3, 1],
			[7, 6, 5, 4, 4]
		);
		
		var path4 : Path = buildPath(
			[7, 6, 1, 1],
			[7, 6, 6, 4]
		);
		
		var nest1 : Nest = buildNest(0, 0);
		nest1.Life = new GeneratedValue(40, 40);
		nest1.Speed = new GeneratedValue(2.5, 2);
		nest1.Armor = new GeneratedValue(10, 10);
		nest1.Interval = new GeneratedValue(500, 200);
		nest1.Paths = [path1, path2];
		add(nest1);
		
		var nest2 : Nest = buildNest(7, 7);
		nest2.Life = new GeneratedValue(40, 40);
		nest2.Speed = new GeneratedValue(2.5, 2);
		nest2.Armor = new GeneratedValue(10, 10);
		nest2.Interval = new GeneratedValue(500, 200);
		nest2.Paths = [path3, path4];
		add(nest2);
		
		Enemy.maxLife  = 80;
		Enemy.maxSpeed = 5;
		Enemy.maxArmor = 20;
		
		add(buildGoal(1, 4));
		
		add(new Display());
		
		var debug : DebugDisplay = new DebugDisplay();
		debug.prepare([nest1, nest2]);
		add(debug);
	}
	
	private function intro()
	{
		new Fader(0x000000, 1, 0, DateTools.seconds(1));
	}
	
	public var m_cellSize : Int;
	
	public var m_sizeX : Int;
	public var m_sizeY : Int;
	
	public var m_available : Array<Int>;
	public var m_type : Array<Int>;
}