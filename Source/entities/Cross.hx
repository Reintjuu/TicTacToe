package entities;

import openfl.display.Sprite;
import openfl.events.Event;

class Cross extends Sprite
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
		removeEventListener(Event.ADDED_TO_STAGE, added);

		var duration:Float = .5;
		var thickness:Int = 10;
		var offset:Int = 15;

		var first:Line = new Line(0 + offset, 0 + offset, size - offset, size - offset, duration, thickness, 0x00FF00);
		var second:Line = new Line(size - offset, 0 + offset, 0 + offset, size - offset, duration, thickness, 0x00FF00, duration);
		addChild(first);
		addChild(second);
	}
}
