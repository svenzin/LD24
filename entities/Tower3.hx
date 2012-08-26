package entities;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;

class Tower3 extends Tower
{

	public function new(x : Float, y : Float, cellSize : Int) 
	{
		super(x, y, cellSize);
		setup(6, 10, 300, 10);
	}
	
	public override function makeInstanceGraphic(cellSize : Int) : Graphic
	{
		return Tower3.makeGraphic(cellSize);
	}
	
	public static override function makeGraphic(cellSize : Int)
	{
		var delta = Math.floor(0.2 * cellSize);
		var image : Image = Image.createRect(cellSize - 2 * delta, cellSize - 2 * delta, 0x4040A0);
		image.x = delta;
		image.y = delta;
		return image;
	}
}
