package entities;

import openfl.events.Event;
import openfl.display.Sprite;
import Main.Position;

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
		removeEventListener(Event.ADDED_TO_STAGE, added);
		
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
			var line:Line = new Line(p.startX, p.startY, p.endX, p.endY, thickness, color, true, duration, animationDelay * i);
			if (i == positions.length - 1) line.setOnAnimationComplete(onAnimationComplete);
			addChild(line);
			i++;
		}
	}
}