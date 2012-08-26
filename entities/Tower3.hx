package entities;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;

class Tower3 extends Tower
{

	public function new(x : Float, y : Float, cellSize : Int) 
	{
		super(x, y, cellSize);
		setup(6, 5, 100, 15);
	}
	
	public override function makeInstanceGraphic(cellSize : Int) : Graphic
	{
		return Tower3.makeGraphic(cellSize);
	}
	
	public static override function makeGraphic(cellSize : Int)
	{
		var radius = Math.floor(cellSize / 2);
		var delta = Math.floor(0.2 * cellSize);
		var image : Image = Image.createCircle(radius - delta, 0x4040A0);
		image.x = delta;
		image.y = delta;
		return image;
	}
}
