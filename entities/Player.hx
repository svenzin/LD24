package entities;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class Player extends Entity
{

	public function new(x : Float, y : Float) 
	{
		super(x, y);
		
		sprite = new Spritemap("gfx/Ship.png", 32, 32);
		sprite.add("idle", [0]);
		sprite.add("thrust", [1, 2, 3], 12);
		
		sprite.play("idle");
		
		graphic = sprite;
		
		Input.define("left", [Key.LEFT, Key.S]);
		Input.define("right", [Key.RIGHT, Key.F]);
	}
	
	private function handleInput()
	{
		velocity = 0;
		
		if (Input.check("left"))
		{
			velocity = -2;
		}
		
		if (Input.check("right"))
		{
			velocity =  2;
		}
	}
	
	private function setAnimations()
	{
		if (velocity == 0)
		{
			sprite.play("idle");
		}
		else
		{
			sprite.play("thrust");
		}
	}
	
	public override function update()
	{
		handleInput();
		moveBy(velocity, 0);
		setAnimations();
		
		super.update();
	}

	private var velocity : Float;
	private var sprite : Spritemap;
}