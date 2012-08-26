package entities.effects;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

class Fader extends Entity
{

	public function new(color : Int, alphaFrom : Float, alphaTo : Float, duration : Float) 
	{
		super();
		
		m_from = alphaFrom;
		m_to = alphaTo;
		m_duration = duration;// .getTime();
		
		setOrigin(0, 0);
		
		m_fader = Image.createRect(HXP.width, HXP.height, color);
		setGraphic(m_fader);
		setLayer(Global.FaderLayer);
		
		m_start = Date.now().getTime();
		
		HXP.world.add(this);
	}
	
	public override function update()
	{
		var now : Float = Date.now().getTime();
		if (now - m_start < m_duration)
		{
			m_fader.alpha = m_from + (now - m_start) / m_duration * (m_to - m_from);
		}
		else
		{
			m_fader.alpha = m_to;
			HXP.world.remove(this);
		}
		
		super.update();
	}
	
	private var m_from : Float;
	private var m_to : Float;
	private var m_start : Float;
	private var m_duration : Float;
	private var m_fader : Image;
	
}