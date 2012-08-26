package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Goal extends Entity
{

	public function new(x : Int, y : Int, cellSize : Int) 
	{
		super(x, y);
		
		var delta : Int = Math.floor(0.1 * cellSize);
		var image : Image = Image.createRect(cellSize - 2 * delta, cellSize - 2 * delta, 0x00A000);
		image.x = delta;
		image.y = delta;
		setGraphic(image);
	}
	
}