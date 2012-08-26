package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import data.GeneratedValue;

class DebugDisplay extends Entity
{

	public function new() 
	{
		super(0, 0);
		setLayer(-1);
	}
	
	public function prepare(debugNests : Array<Nest>)
	{
		Nests = debugNests;
		m_nestsText = new Array<Text>();
		
		for (index in 0...Nests.length)
		{
			var text : Text = new Text("A");
			text.x = 0;
			text.y = 16 * index;
			text.resizable = true;
			
			m_nestsText.push(text);
			addGraphic(text);
		}
	}
	
	public override function update()
	{
		if (DebugDisplay.IsOn)
		{
			display();
		}
		super.update();
	}
	
	private function generatedValueString(value : GeneratedValue) : String
	{
		var text : StringBuf = new StringBuf();
		text.add("(");
		text.add(Math.floor(1000 * value.Average));
		text.add(" ");
		text.add(Math.floor(1000 * value.Variability));
		text.add(")");
		return text.toString();
	}
	private function display()
	{
		for (index in 0...Nests.length)
		{
			var text : StringBuf = new StringBuf();
			text.add(index);
			text.add(" : ");
			text.add(generatedValueString(Nests[index].Life));
			text.add(generatedValueString(Nests[index].Speed));
			text.add(generatedValueString(Nests[index].Armor));
			m_nestsText[index].text = text.toString();
		}
	}

	public static var IsOn : Bool = true;
	
	public var Nests : Array<Nest>;
	private var m_nestsText : Array<Text>;
}