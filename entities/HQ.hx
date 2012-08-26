package entities;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Graphiclist;
import data.Rect;
import flash.filters.DisplacementMapFilter;

class HQ extends Cell
{

	public function new(x : Int, y : Int) 
	{
		super(x, y);
		type = "hq";
		setHitbox(Cell.SIZE, Cell.SIZE);
	}
	
	public override function buildGraphic()
	{
		var cellGraphic : Graphic = Image.createRect(Cell.SIZE - 1, Cell.SIZE - 1, 0x808080);
		
		m_renderMaterial = Image.createRect(2, 2, 0xA0A000);
		m_renderMaterial.x = 1;
		m_renderMaterial.y = 1;
		m_renderMaterial.relative = true;
		
		graphic = new Graphiclist([cellGraphic, m_renderMaterial]);
	}
	
	public function workerDied()
	{
	}
	
	public function createWorker() : Worker
	{
		var m : entities.Map = cast(HXP.world, worlds.GameWorld).map;
		var limits : Rect = new Rect(0, m.sizeX * Cell.SIZE, 0, m.sizeY * Cell.SIZE);
		
		var newWorker : Worker = new Worker();
		newWorker.setup(this, limits, 1000, 2, 0.4, 0.2);
		newWorker.moveTo(centerX, centerY);
		
		return newWorker;
	}
	
}