package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import data.Connection;

class Map extends Entity
{

	public function new(xCount : Int, yCount : Int) 
	{
		super();
		
		sizeX = xCount;
		sizeY = yCount;
		
		m_cells = new Array<Cell>();
		for (y in 0...sizeY)
		{
			for (x in 0...sizeX)
			{
				createCell(x, y);
			}
		}
	}
	
	private function createCell(x : Int, y : Int)
	{
		var cell : Cell = new Cell(Cell.SIZE * x, Cell.SIZE * y);
		cell.setup(1);
		
		HXP.world.add(cell);
		m_cells.push(cell);
	}
	
	public function get(x : Int, y : Int) : Cell
	{
		return m_cells[sizeX * y + x];
	}
	
	public function set(x : Int, y : Int, value : Cell)
	{
		HXP.world.remove(get(x, y));
		
		HXP.world.add(value);
		m_cells[sizeX * y + x] = value;
	}
	
	public var sizeX(default, null) : Int;
	public var sizeY(default, null) : Int;
	public var m_cells : Array<Cell>;
}
