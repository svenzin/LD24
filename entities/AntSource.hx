package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.World;
import data.Path;

class AntSource extends Entity
{

	public function new(x : Float, y : Float, path : Path, tower : Tower) 
	{
		super(x, y);
		
		m_path = path;
		m_tower = tower;
		
		graphic = new Image("gfx/AntSource.png");
		
		m_nextBirth = Date.now();
	}
	
	private function giveBirth()
	{
		var a : Ant = cast(HXP.world.create(Ant), Ant);
		
		a.setup(x, y, Math.random(), Math.random(), Math.random());
		a.follow(m_path, m_tower);
	}
	
	public override function update()
	{
		if (Date.now().getTime() >= m_nextBirth.getTime())
		{
			m_nextBirth = Date.fromTime(m_nextBirth.getTime() + 1000);
			giveBirth();
		}
		
		super.update();
	}
	
	private var m_nextBirth : Date;
	private var m_path : Path;
	private var m_tower : Tower;
}