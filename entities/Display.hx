package entities;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.graphics.Graphiclist;
import flash.sampler.NewObjectSample;
import worlds.GameWorld;

class Display extends Entity
{

	public function new() 
	{
		super(16 * 32, 0);
		setHitbox(HXP.width - 16 * 32, HXP.height);
		
		var bg : Image = Image.createRect(width, height, 0x404040);
		
		layer = -1;
		
		var tower1Text : Text = new Text("1 :");
		tower1Text.x = 0;
		tower1Text.y = 0;
		m_tower1 = Tower1.makeGraphic(32);
		m_tower1.x = 32;
		m_tower1.y = 0;
		
		var tower2Text : Text = new Text("2 :");
		tower2Text.x = 0;
		tower2Text.y = 32;
		m_tower2 = Tower2.makeGraphic(32);
		m_tower2.x = 32;
		m_tower2.y = 32;
		
		var tower3Text : Text = new Text("3 :");
		tower3Text.x = 0;
		tower3Text.y = 2 * 32;
		m_tower3 = Tower3.makeGraphic(32);
		m_tower3.x = 32;
		m_tower3.y = 2 * 32;
		
		graphic = new Graphiclist([
			bg,
			tower1Text, m_tower1,
			tower2Text, m_tower2,
			tower3Text, m_tower3,
			m_materialLife, m_materialRange, m_materialSpeed, m_materialDamage
		]);
	}
	
	public override function update()
	{
	}

	private var m_tower1 : Graphic;
	private var m_tower2 : Graphic;
	private var m_tower3 : Graphic;
	
	private var m_materialLife : Text;
	private var m_materialSpeed : Text;
	private var m_materialRange : Text;
	private var m_materialDamage : Text;
}