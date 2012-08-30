package worlds;

import com.haxepunk.HXP;
import com.haxepunk.World;

class TutorialWorld extends World
{

	public function new() 
	{
		super();
	}
	
	public override function begin()
	{
		HXP.world = new Menu();
		super.begin();
	}
}