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

	private var currentAngle:Float = 0;

	public function new(x:Float, y:Float, radius:Float, thickness:Float, color:Int, duration:Float, ?onAnimationComplete:Void -> Void)
	{
		super();
		this.x = x + radius;
		this.y = y + radius;
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
		Actuate.tween(this, duration, { currentAngle: 360 }).ease(Quint.easeOut).onUpdate(render).onComplete(onAnimationComplete);
	}

	private function render()
	{
		graphics.clear();

		graphics.beginFill(color, 1);
		drawWedge(this, 0, 0, radius, currentAngle, -90);

		/* I actually wanted to code it like (with one begin- and endFill)...
		 *
		 * // Subtract out the middle by drawing a new wedge over the top of the previous one.
		 * drawWedge(this, 0, 0, radius - thickness, currentAngle, -90);
		 *
		 * ...but HTML5 doesn't support it this way as it's not cutting out the middle part of the wedge. Of course all
		 * other targets have no problems with this, but I simply have to do it in this ugly way to be FULLY cross-platform.
		 */

		graphics.endFill();

		// Subtract out the middle by drawing a circle over the top of the drawn wedge.
		graphics.beginFill(stage.color, 1);
		graphics.drawCircle(0, 0, radius - thickness);
		graphics.endFill();
	}

	private function drawWedge(sprite:Sprite, startX:Int, startY:Int, radius:Float, arc:Float, startAngle:Int = 0)
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
		sprite.graphics.moveTo(startX, startY);

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
		ax = startX + Math.cos(angle) * radius;
		ay = startY + Math.sin(angle) * radius;
		
		// Draw the first line.
		sprite.graphics.lineTo(ax, ay);
		
		// Draw the wedge.
		for (i in 0...numOfSegs)
		{
			angle += segAngle;
			angleMid = angle - (segAngle * .5);
			bx = startX + Math.cos(angle) * radius;
			by = startY + Math.sin(angle) * radius;
			cx = startX + Math.cos(angleMid) * (radius / Math.cos(segAngle * .5));
			cy = startY + Math.sin(angleMid) * (radius / Math.cos(segAngle * .5));
			sprite.graphics.curveTo(cx, cy, bx, by);
		}
		
		// Close the wedge.
		sprite.graphics.lineTo(startX, startY);
	}
}