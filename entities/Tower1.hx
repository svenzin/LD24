package entities;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;

class Tower1 extends Tower
{

	public function new(x : Float, y : Float, cellSize : Int) 
	{
		super(x, y, cellSize);
		setup(3, 20, 200, 0);
	}
	
	public override function makeInstanceGraphic(cellSize : Int) : Graphic
	{
		return Tower1.makeGraphic(cellSize);
	}
	
	public static override function makeGraphic(cellSize : Int)
	{
		var radius = Math.floor(cellSize / 2);
		var delta = Math.floor(0.2 * cellSize);
		var image : Image = Image.createCircle(radius - delta, 0xA04040);
		image.x = delta;
		image.y = delta;
		return image;
	}
}
