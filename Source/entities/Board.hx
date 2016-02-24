package entities;

import openfl.events.Event;
import openfl.display.Sprite;

typedef Position = { startX:Float, startY:Float, endX:Float, endY:Float };

class Board extends Sprite
{
	private var size:Float;
	private var onAnimationComplete:Void -> Void;

	public function new(x:Float, y:Float, size:Float, onAnimationComplete:Void -> Void)
	{
		super();
		this.x = x;
		this.y = y;
		this.size = size;
		this.onAnimationComplete = onAnimationComplete;

		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e)
	{
		var positions:Array<Position> = [
			{startX: -size * .5, startY: -size / 6, endX: size * .5, endY: -size / 6},
			{startX: -size * .5, startY: size / 6, endX: size * .5, endY: size / 6},
			{startX: -size / 6, startY: -size * .5, endX: -size / 6, endY: size * .5},
			{startX: size / 6, startY: -size * .5, endX: size / 6, endY: size * .5}
		];

		var duration:UInt = 2;
		var thickness:UInt = 10;
		var color:UInt = 0xFF0000;
		var animationDelay:Float = .5;

		var i:Int = 0;
		for (p in positions)
		{
			var line:Line = new Line(p.startX, p.startY, p.endX, p.endY, duration, thickness, color, animationDelay * i);
			if (i == positions.length - 1) line.setOnAnimationComplete(onAnimationComplete);
			addChild(line);
			i++;
		}
	}
}
