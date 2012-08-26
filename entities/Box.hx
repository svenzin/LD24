package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Box extends Entity
{

	public function new(range : Int) 
	{
		super();
		
		setRange(range);
	}
	
	public function getRange() : Int
	{
		return m_range;
	}
	
	public function setRange(range : Int)
	{
		m_range = range;
		setHitbox(2 * m_range, 2 * m_range);
	}
	
	private var m_range : Int;
}