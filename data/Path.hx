package data;

class Path 
{

	public function new() 
	{
		waypoints = new List<WayPoint>();
	}
	
	public function append(x : Int, y : Int)
	{
		waypoints.add(new WayPoint(x, y));
	}
	
	public var waypoints : List<WayPoint>;
	
}