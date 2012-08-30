package worlds;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.World;
import entities.effects.Fader;

enum MenuAction
{
	NEW_GAME;
	HELP;
}

class Menu extends World
{

	public function new() 
	{
		super();
	}
	
	public override function begin()
	{
		m_title = new Text("Defend Against Evolution!");
		m_title.x = HXP.halfWidth - cast(m_title, Text).width / 2;
		m_title.y = 100;
		
		m_newGame = new Text("New Game");
		m_newGame.x = HXP.halfWidth - cast(m_newGame, Text).width / 2;
		m_newGame.y = 300;
		
		m_help = new Text("How to Play");
		m_help.x = HXP.halfWidth - cast(m_help, Text).width / 2;
		m_help.y = 350;
		
		var menu : Graphic = new Graphiclist([m_title, m_newGame, m_help]);
		addGraphic(menu);
		
		intro();
		
		super.begin();
	}
	
	private function enable()  { m_hasControl = true; }
	private function disable() { m_hasControl = false; }
	
	private function intro()
	{
		disable();
		m_selected = NEW_GAME;
		new Fader(0x000000, 1, 0, DateTools.seconds(1)).Callback = enable;
	}
	
	private function outro(newWorld : World)
	{
		disable();
		new Fader(0x000000, 0, 1, DateTools.seconds(1)).Callback = function() { HXP.world = newWorld; };
	}
	
	private function getActionGraphic() : Image
	{
		switch (m_selected)
		{
			case NEW_GAME: return m_newGame;
			case HELP:	   return m_help;
		}
	}
	
	private function getNextAction(action : MenuAction) : MenuAction
	{
		switch (action)
		{
			case NEW_GAME: return HELP;
			case HELP:	   return NEW_GAME;
		}
	}
	
	private function getPreviousAction(action : MenuAction) : MenuAction
	{
		switch (action)
		{
			case NEW_GAME: return HELP;
			case HELP:	   return NEW_GAME;
		}
	}
	
	private function updateSelectedAction()
	{
		m_newGame.alpha = 0.5;
		m_help.alpha = 0.5;
		
		getActionGraphic().alpha = 1.0;
	}
	
	private function executeSelectedAction()
	{
		switch (m_selected)
		{
			case NEW_GAME: outro(new DefenseWorld());
			case HELP:     outro(new TutorialWorld());
		}
	}
	
	public override function update()
	{
		if (m_hasControl)
		{
			if (Input.pressed(Key.UP))   m_selected = getPreviousAction(m_selected);
			if (Input.pressed(Key.DOWN)) m_selected = getNextAction(m_selected);
			
			if (Input.pressed(Key.ENTER))
			{
				executeSelectedAction();
			}
		}
		
		updateSelectedAction();
		
		super.update();
	}
	
	private var m_hasControl : Bool;
	private var m_selected : MenuAction;
	
	private var m_title : Graphic;
	private var m_newGame : Image;
	private var m_help : Image;
}