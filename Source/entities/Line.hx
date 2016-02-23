package entities;

import motion.easing.Quint;
import motion.Actuate;
import openfl.geom.Point;
import openfl.events.Event;
import openfl.display.Sprite;

class Line extends Sprite
{
	private var start:Point;
	private var end:Point;
	private var duration:Float;
	private var thickness:Float;
	private var color:Int;
	private var callback:Void->Void;
	private var animationDelay:Float;

	public function new(startX:Float, startY:Float, endX:Float, endY:Float, duration:Float, thickness:Float, color:Int, ?animationDelay:Float = 0)
	{
		super();
		this.start = new Point(startX, startY);
		this.end = new Point(endX, endY);
		this.duration = duration;
		this.thickness = thickness;
		this.color = color;
		this.animationDelay = animationDelay;

		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	public function onAnimationComplete(callback:Void->Void)
	{
		this.callback = callback;
	}

	private function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);

		graphics.clear();
		graphics.lineStyle(thickness, color, 1);
		graphics.moveTo(start.x, start.y);
		Actuate.tween(start, duration, { x: end.x, y: end.y }).ease(Quint.easeOut).delay(animationDelay).onUpdate(render).onComplete(callback);
	}

	private function render()
	{
		graphics.lineTo(start.x, start.y);
	}
}