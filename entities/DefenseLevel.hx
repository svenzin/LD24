package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

enum Action
{
	None;
	Destroy;
	Turret1;
	Turret2;
	Turret3;
}

class DefenseLevel extends Entity
{

	public function new(types : Array<Int>, available : Array<Int>, sizeX : Int, sizeY : Int, cellSize : Int) 
	{
		super();
		
		m_unknown = 0xA0A0A0;
		m_blocks = [0x404040, 0x808080];

		var graphics : Graphiclist = new Graphiclist();
		for (y in 0...sizeY)
		{
			for (x in 0...sizeX)
			{
				var type : Int = types[sizeX * y + x];
				
				var block : Int;
				if (type >= 0 && type < m_blocks.length)
				{
					block = m_blocks[type];
				}
				else
				{
					block = m_unknown;
				}
				
				var blockGraphic : Image = Image.createRect(cellSize - 1, cellSize - 1, block);
				blockGraphic.x = cellSize * x;
				blockGraphic.y = cellSize * y;
				
				graphics.add(blockGraphic);
			}
		}
		
		m_selected = Image.createRect(cellSize, cellSize, 0xFFFFFF);
		graphics.add(m_selected);
		
		setGraphic(graphics);
		
		setup(available, sizeX, sizeY, cellSize);
	}
	
	public function setup(available : Array<Int>, sizeX : Int, sizeY : Int, cellSize : Int)
	{
		m_cellSize = cellSize;
		m_sizeX = sizeX;
		m_sizeY = sizeY;
		m_available = available;
		
		m_action = None;
		Input.define("None", [Key.ESCAPE]);
		Input.define("Destroy", [Key.BACKSPACE, Key.X]);
		Input.define("Tower1", [Key.DIGIT_1]);
		Input.define("Tower2", [Key.DIGIT_2]);
		Input.define("Tower3", [Key.DIGIT_3]);
	}
	
	public override function update()
	{
		setAction();
		displayAction();
		
		super.update();
	}
	
	private function buildTower(x : Int, y : Int, type : Action) : Tower
	{
		switch (type)
		{
			case Turret1: return new Tower1(m_cellSize * x, m_cellSize * y, m_cellSize);
			case Turret2: return new Tower2(m_cellSize * x, m_cellSize * y, m_cellSize);
			case Turret3: return new Tower3(m_cellSize * x, m_cellSize * y, m_cellSize);
			default: return null;
		}
	}
	
	private function setAction()
	{
		if (Input.pressed("None"))    m_action = None;
		if (Input.pressed("Destroy")) m_action = Destroy;
		if (Input.pressed("Tower1"))  m_action = Turret1;
		if (Input.pressed("Tower2"))  m_action = Turret2;
		if (Input.pressed("Tower3"))  m_action = Turret3;
		
		var x = Math.floor(Input.mouseX / m_cellSize);
		var y = Math.floor(Input.mouseY / m_cellSize);
		
		if (Input.mousePressed)
		{
			if ((m_action == Turret1) || (m_action == Turret2) || (m_action == Turret3))
			{
				if (isAvailable(x, y) && canBuild())
				{
					setAvailable(x, y, false);
					
					var tower : Tower = buildTower(x, y, m_action);
					HXP.world.add(tower);
					
					m_action = None;
				}
			}
			
			if (m_action == Destroy)
			{
				if (!isAvailable(x, y))
				{
					var tower : Entity = HXP.world.collidePoint("Tower", Input.mouseX, Input.mouseY);
					if (tower != null)
					{
						m_action = None;
						setAvailable(x, y, true);
						
						HXP.world.remove(tower);
					}
				}
			}
		}
	}
	
	private function setSelected(x : Int, y : Int, alpha : Float, color : Int)
	{
		m_selected.x = m_cellSize * x;
		m_selected.y = m_cellSize * y;
		m_selected.alpha = alpha;
		m_selected.color = color;
	}
	
	private function setAvailable(x : Int, y : Int, available : Bool)
	{
		if (available) m_available[m_sizeX * y + x] = 1;
		else m_available[m_sizeX * y + x] = 0;
	}
	
	private function isAvailable(x : Int, y : Int) : Bool
	{
		return m_available[m_sizeX * y + x] != 0;
	}
	
	private function canBuild() : Bool
	{
		var count : Int = HXP.world.typeCount("Tower");
		return count < Score.MaximumTowersCount;
	}
	
	private function isInside(x : Int, y : Int) : Bool
	{
		return (x >= 0) && (x < m_sizeX) &&
			   (y >= 0) && (y < m_sizeY);
	}
	
	private function displayAction()
	{
		var x = Math.floor(Input.mouseX / m_cellSize);
		var y = Math.floor(Input.mouseY / m_cellSize);
		
		if (m_action == None)
		{
			setSelected(x, y, 0, 0);
		}
		
		if ((m_action == Turret1) || (m_action == Turret2) || (m_action == Turret3))
		{
			if (isInside(x, y))
				if (isAvailable(x, y) && canBuild())
					setSelected(x, y, 0.5, 0xFFFFFF);
				else
					setSelected(x, y, 0.5, 0xFF0000);
			else
				setSelected(x, y, 0, 0);
		}
		
		if (m_action == Destroy)
		{
			if (isInside(x, y))
				if (isAvailable(x, y))
				{
					var tower : Entity = HXP.world.collidePoint("Tower", Input.mouseX, Input.mouseY);
					if (tower != null)
						setSelected(x, y, 0.5, 0xFFFFFF);
					else
						setSelected(x, y, 0.5, 0xFF0000);
				}
				else
					setSelected(x, y, 0.5, 0xFF0000);
			else
				setSelected(x, y, 0, 0);
		}
	}
	
	var m_selected : Image;
	
	var m_unknown : Int;
	var m_blocks  : Array<Int>;
	var m_action  : Action;
	
	var m_cellSize : Int;
	var m_sizeX : Int;
	var m_sizeY : Int;
	var m_available : Array<Int>;
}