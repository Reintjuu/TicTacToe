package entities;

import openfl.display.Sprite;
import openfl.events.Event;

class Cross extends Sprite
{
	public function new(x:Float, y:Float)
	{
		super();
		this.x = x;
		this.y = y;
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);

		var duration:Float = .5;
		var thickness:Int = 10;
		var offset:Int = 15;

		var first:Line = new Line(0 + offset, 0 + offset, 100 - offset, 100 - offset, duration, thickness, 0x00FF00);
		var second:Line = new Line(100 - offset, 0 + offset, 0 + offset, 100 - offset, duration, thickness, 0x00FF00, duration);
		addChild(first);
		addChild(second);
	}
}
