package entities;

import com.haxepunk.Entity;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Tilemap;
import com.haxepunk.graphics.Graphiclist;
import data.Connection;

class Cell extends Entity
{
	public static var SIZE : Int = 32;
	
	public function new(x : Int, y : Int) 
	{
		super(x, y);
		buildGraphic();
		buildLinks();
		
		layer = 2;
		type = "cell";
	}
	
	public static function getConnection(index : Int) : Connection
	{
		switch (index)
		{
			case 0:  return new Connection( 1,  0);
			case 1:  return new Connection(-1,  0);
			case 2:  return new Connection( 0,  1);
			default: return new Connection( 0, -1);
		}
	}
	private function buildLinks()
	{
		m_gatherLinks = new Array<Float>();
		for (connection in 0...4)
		{
			m_gatherLinks.push(0);
		}
	}
	
	private function buildGraphic()
	{	
		var cellGraphic : Image = Image.createRect(Cell.SIZE - 1, Cell.SIZE - 1, 0x404040);
	
		m_renderMaterial = Image.createRect(2, 2, 0x808000);
		m_renderMaterial.x = 1;
		m_renderMaterial.y = 1;
		m_renderMaterial.relative = true;
		
		graphic = new Graphiclist([cellGraphic, m_renderMaterial]);
	}
	
	public function setup(materialAmount : Int)
	{
		material = materialAmount;
	}
	
	public override function update()
	{
		m_renderMaterial.scaleX = material;
		
		super.update();
	}
	
	public var material(default, default) : Int;
	private var m_renderMaterial : Image;

	public var m_connections : Array<Connection>;
	public var m_gatherLinks : Array<Float>;
}