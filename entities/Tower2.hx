package entities;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;

class Tower2 extends Tower
{

	public function new(x : Float, y : Float, cellSize : Int) 
	{
		super(x, y, cellSize);
		setup(5, 15, 200, 8);
	}
	
	public override function makeInstanceGraphic(cellSize : Int) : Graphic
	{
		return Tower2.makeGraphic(cellSize);
	}
	
	public static override function makeGraphic(cellSize : Int)
	{
		var radius = Math.floor(cellSize / 2);
		var delta = Math.floor(0.2 * cellSize);
		var image : Image = Image.createCircle(radius - delta, 0x40A040);
		image.x = delta;
		image.y = delta;
		return image;
	}
}
