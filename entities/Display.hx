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
		
		setLayer(Global.GuiLayer);
		
		var tower1Text : Text = new Text("[1]");
		tower1Text.x = 0;
		tower1Text.y = 0;
		m_tower1 = Tower1.makeGraphic(32);
		m_tower1.x = 32;
		m_tower1.y = 0;
		
		var tower2Text : Text = new Text("[2]");
		tower2Text.x = 0;
		tower2Text.y = 32;
		m_tower2 = Tower2.makeGraphic(32);
		m_tower2.x = 32;
		m_tower2.y = 32;
		
		var tower3Text : Text = new Text("[3]");
		tower3Text.x = 0;
		tower3Text.y = 2 * 32;
		m_tower3 = Tower3.makeGraphic(32);
		m_tower3.x = 32;
		m_tower3.y = 2 * 32;
		
		m_towers = new Text("");
		m_towers.x = 0;
		m_towers.y = 4 * 32;
		m_towers.resizable = true;
		
		var survivorsText : Text = new Text("Survivors");
		survivorsText.x = 0;
		survivorsText.y = 6 * 32;
		
		graphic = new Graphiclist([
			bg,
			tower1Text, m_tower1,
			tower2Text, m_tower2,
			tower3Text, m_tower3,
			m_towers, 
			survivorsText
		]);
	}
	
	public override function update()
	{
		var count : Int = HXP.world.typeCount("Tower");
		
		var builder : StringBuf = new StringBuf();
		builder.add("Towers ");
		builder.add(count);
		builder.add(" / ");
		builder.add(Score.MaximumTowersCount);
		m_towers.text = builder.toString();
	}
	
	public function addWave(index : Int, kills : Int)
	{
		var waveResuts : StringBuf = new StringBuf();
		waveResuts.add(index + 1);
		waveResuts.add(". ");
		waveResuts.add(kills);
		
		var waveText : Text = new Text(waveResuts.toString());
		waveText.x = 0;
		waveText.y = (7 + index) * 32;
		addGraphic(waveText); 
	}

	private var m_tower1 : Graphic;
	private var m_tower2 : Graphic;
	private var m_tower3 : Graphic;	
	
	private var m_towers : Text;
}