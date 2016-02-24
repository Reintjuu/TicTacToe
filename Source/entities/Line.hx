package entities;

import motion.MotionPath;
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
	private var onAnimationComplete:Void->Void;
	private var animationDelay:Float;

	public function new(startX:Float, startY:Float, endX:Float, endY:Float, duration:Float, thickness:Float, color:Int, ?animationDelay:Float = 0, ?onAnimationComplete:Void->Void)
	{
		super();
		this.start = new Point(startX, startY);
		this.end = new Point(endX, endY);
		this.duration = duration;
		this.thickness = thickness;
		this.color = color;
		this.animationDelay = animationDelay;
		this.onAnimationComplete = onAnimationComplete;

		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	public function setOnAnimationComplete(callback:Void->Void)
	{
		this.onAnimationComplete = callback;
	}

	private function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);

		graphics.clear();
		graphics.lineStyle(thickness, color, 1);
		graphics.moveTo(start.x, start.y);

		var path = new MotionPath().line(end.x, end.y);
		Actuate.motionPath(start, duration, {x: path.x, y: path.y }).ease(Quint.easeOut).delay(animationDelay).onUpdate(render).onComplete(onAnimationComplete);
	}

	private function render()
	{
		graphics.lineTo(start.x, start.y);
	}
}