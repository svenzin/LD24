import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.World;

import worlds.Menu;

class Main extends Engine
{

	public static inline var kScreenWidth:Int = 640;
	public static inline var kScreenHeight:Int = 512;
	public static inline var kFrameRate:Int = 30;
	public static inline var kClearColor:Int = 0x000000;
	public static inline var kProjectName:String = "HaxePunk";

	public function new()
	{
		super(kScreenWidth, kScreenHeight, kFrameRate, false);
	}

	override public function init()
	{
#if debug
	#if flash
		if (flash.system.Capabilities.isDebugger)
	#end
		{
			HXP.console.enable();
		}
#end
		HXP.screen.color = kClearColor;
		HXP.screen.scale = 1;
		
		HXP.world = new Menu();
	}

	public static function main()
	{
		new Main();
	}

}