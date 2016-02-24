package entities;

import openfl.display.Graphics;
import Math;
import openfl.geom.Point;
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

	public var i:Float = 0;
	private var p:Point;

	public function new(x:Float, y:Float, radius:Float, thickness:Float, color:Int, duration:Float, ?onAnimationComplete:Void -> Void)
	{
		super();
		this.x = x + radius;
		this.y = y + radius;
		this.point = new Point(x, y);
		this.radius = radius * .8;
		this.thickness = thickness;
		this.color = color;
		this.duration = duration;
		this.onAnimationComplete = onAnimationComplete;

		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		Actuate.tween(this, duration, { i: 360 }).ease(Quint.easeOut).onUpdate(render).onComplete(onAnimationComplete);
	}

	function drawArc(arcRef:Sprite, sx:Int, sy:Int, radius:Int, arc:Float, startAngle:Int = 0)
	{
		var segAngle:Float;
		var angle:Float;
		var angleMid:Float;
		var numOfSegs:Int;
		var ax:Float;
		var ay:Float;
		var bx:Float;
		var by:Float;
		var cx:Float;
		var cy:Float;

		// Move the pen.
		arcRef.graphics.moveTo(sx, sy);

		// No need to draw more than 360.
		if (Math.abs(arc) > 360)
		{
			arc = 360;
		}

		numOfSegs = Math.ceil(Math.abs(arc) / 45);
		segAngle = arc / numOfSegs;
		segAngle = (segAngle / 180) * Math.PI;
		angle = (startAngle / 180) * Math.PI;

		// Calculate the start point.
		ax = sx + Math.cos(angle) * radius;
		ay = sy + Math.sin(angle) * radius;

		// Draw the first line.
		arcRef.graphics.lineTo(ax, ay);

		// Draw the arc.
		for (i in 0...numOfSegs)
		{
			angle += segAngle;
			angleMid = angle - (segAngle / 2);
			bx = sx + Math.cos(angle) * radius;
			by = sy + Math.sin(angle) * radius;
			cx = sx + Math.cos(angleMid) * (radius / Math.cos(segAngle / 2));
			cy = sy + Math.sin(angleMid) * (radius / Math.cos(segAngle / 2));
			arcRef.graphics.curveTo(cx, cy, bx, by);
		}

		// Close the wedge.
		arcRef.graphics.lineTo(sx, sy);
	}

	private function render()
	{
		graphics.clear();
		graphics.beginFill(0x0000FF, 1);
		drawArc(this, 0, 0, cast(radius), i, -90);
		// Subtract out the middle by drawing a new circle over the top of it.
		drawArc(this, 0, 0, cast(radius * .75), i, -90);
		graphics.endFill();
	}
}
