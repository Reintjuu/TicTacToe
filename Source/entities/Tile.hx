package entities;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;

/**
 * ...
 * @author Reinier
 */

class Tile extends Sprite
{
	private var size:Float;
	
	public function new(x:Float, y:Float, size:Float)
	{
		super();
		this.x = x;
		this.y = y;
		this.size = size;
		
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e)
	{
		addChild(new Cross(0, 0, size, 10, 0x00FF00, 1));
	}
}