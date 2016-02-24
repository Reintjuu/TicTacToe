package entities;

import openfl.display.Graphics;
import Math;
import openfl.geom.Point;
import motion.MotionPath;
import motion.easing.Quint;
import motion.Actuate;
import openfl.events.Event;
import openfl.display.Sprite;

class Circle extends Sprite
{
	private var point:Point;
	private var radius:Float;
	private var thickness:Float;
	private var color:Int;
	private var duration:Float;
	private var onAnimationComplete:Void -> Void;

	private var p:Point;

	public function new(x:Float, y:Float, radius:Float, thickness:Float, color:Int, duration:Float, ?onAnimationComplete:Void -> Void)
	{
		super();
		this.x = x + radius;
		this.y = y + radius;
		this.point = new Point(x, y);
		this.radius = radius * .7;
		this.thickness = thickness;
		this.color = color;
		this.duration = duration;
		this.onAnimationComplete = onAnimationComplete;

		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);

		graphics.clear();
		graphics.lineStyle(thickness, color, 1, true);

		var path = new MotionPath();
		var stepsize:Float = .05;
		var angle:Float = 0;
		while (angle < 2 * Math.PI)
		{
			point.x = radius * Math.cos(angle);
			point.y = radius * Math.sin(angle);
			if (angle == 0) graphics.moveTo(point.x, point.y);
			path.line(point.x, point.y);
			angle += stepsize;
		}

		Actuate.motionPath(point, duration, {x: path.x, y: path.y }).ease(Quint.easeOut).onUpdate(render).onComplete(onAnimationComplete);
	}

	private function render()
	{
		graphics.lineTo(point.x, point.y);
	}
}
