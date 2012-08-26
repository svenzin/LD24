package entities;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import worlds.GameWorld;
import data.Rect;
import data.Connection;

enum Activity {
	Gathering;
}

enum SubActivity {
	Gathering_Fetch;
	Gathering_Return;
}

class Worker extends Entity
{

	public function new() 
	{
		super();
		
		var theGraphic : Image = Image.createRect(5, 5, 0xFFFFFF);
		graphic = theGraphic;
		
		setHitbox(5, 5);
		
		layer = 1;
	}
	
	public function setup(hq : HQ, limits : Rect, theLifespan : Int, theSpeed : Int, theWill : Float, theSensitivity : Float)
	{
		HXP.world.add(this);
		
		m_hq = hq;
		m_box = limits;
		
		speed = theSpeed;
		lifespan = theLifespan;
		will = theWill;
		sensitivity = theSensitivity;
		
		activity = Gathering;
		subactivity = Gathering_Fetch;
		
		m_material = 0;
		generateDirection(hq);
	}
	
	public override function update()
	{
		if (getOlder())
		{
			switch (activity)
			{
				case Gathering: gather();
			}
		}
	}
	
	private function gather()
	{
		var cellX : Int = Math.floor(x / Cell.SIZE);
		var cellY : Int = Math.floor(y / Cell.SIZE);
		
		var cell : Cell = cast(HXP.world, GameWorld).map.get(cellX, cellY);
		switch (subactivity)
		{
			case Gathering_Fetch:  gatherFetch(cellX, cellY, cell);
			case Gathering_Return: gatherReturn(cellX, cellY, cell);
			
			default: subactivity = Gathering_Fetch;
		}
	}
	
	private function gatherReturn(cellX : Int, cellY : Int, cell : Cell)
	{
		if (cell == m_hq)
		{
			cell.material += m_material;
			m_material = 0;
			
			subactivity = Gathering_Fetch;
		}
		else
		{
			moveTowards(m_hq.x, m_hq.y, speed);
		}
	}
	
	private function generateDirection(from : Cell)
	{
		var maxWeight : Float = -1;
		var maxIndex : Int = -1;
		for (index in 0...from.m_gatherLinks.length)
		{
			var weight : Float = from.m_gatherLinks[index];
			if (weight > sensitivity && weight > maxWeight)
			{
				maxWeight = from.m_gatherLinks[index];
				maxIndex  = index;
			}
		}
		
		if (maxIndex == -1)
		{
			maxIndex = Math.floor(Math.random() * from.m_gatherLinks.length);
		}
		
		var connect : Connection = Cell.getConnection(maxIndex);
		m_dx = connect.dX;
		m_dy = connect.dY;
	}
	
	private function gatherFetch(cellX : Int, cellY : Int, cell : Cell)
	{
		if ((cell != m_hq) && (cell.material > 0))
		{
			m_material = 1;
			cell.material -= m_material;
			
			subactivity = Gathering_Return;
		}
		else
		{
			if (Math.random() >= will)
			{
				generateDirection(cell);
			}
			
			moveBy(speed * m_dx, speed * m_dy);
			x = Math.max(x, m_box.Xmin);
			x = Math.min(x, m_box.Xmax);
			y = Math.max(y, m_box.Ymin);
			y = Math.min(y, m_box.Ymax);
		}
	}
	
	private function getOlder() : Bool
	{
		lifespan--;
		if (lifespan <= 0) die();
		return lifespan > 0;
	}
	
	public function die()
	{
		m_hq.workerDied();
		
		HXP.world.remove(this);
	}

	public var speed(default, null) : Int;
	public var lifespan(default, null) : Int;
	public var will(default, null) : Float;
	public var sensitivity(default, null) : Float;
	
	public var activity(default, null) : Activity;
	private var subactivity : SubActivity;
	
	private var m_dx : Float;
	private var m_dy : Float;
	
	private var m_material : Int;
	
	private var m_hq : HQ;
	private var m_box : Rect;
}