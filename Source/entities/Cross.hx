package entities;

import openfl.display.Sprite;
import openfl.events.Event;

class Cross extends Sprite
{
	private var size:Float;
	private var thickness:Float;
	private var color:Int;
	private var duration:Float;
	private var onAnimationComplete:Void -> Void;

	public function new(x:Float, y:Float, size:Float, thickness:Float, color:Int, duration:Float, ?onAnimationComplete:Void -> Void)
	{
		super();
		this.x = x;
		this.y = y;
		this.size = size;
		this.thickness = thickness;
		this.color = color;
		this.duration = duration;
		this.onAnimationComplete = onAnimationComplete;

		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);

		var offset:Float = size * .15;

		var first:Line = new Line(0 + offset, 0 + offset, size - offset, size - offset, duration, thickness, color);
		var second:Line = new Line(size - offset, 0 + offset, 0 + offset, size - offset, duration, thickness, color, duration, onAnimationComplete);
		addChild(first);
		addChild(second);
	}
}
