package data;

/**
 * ...
 * @author scorder
 */

class Rect 
{

	public function new(minx : Int, maxx : Int, miny : Int, maxy : Int) 
	{
		Xmin = minx;
		Xmax = maxx;
		Ymin = miny;
		Ymax = maxy;
	}
	
	public var Xmin : Int;
	public var Xmax : Int;
	
	public var Ymin : Int;
	public var Ymax : Int;
	
}