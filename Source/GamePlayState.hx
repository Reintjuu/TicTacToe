package;

import entities.Cross;
import UInt;
import openfl.geom.Point;
import entities.Line;
import openfl.display.Sprite;

/**
 * State where all the game magic happens.
 * @author Reinier de Vries
*/
typedef Position = { startX:Float, startY:Float, endX:Float, endY:Float };

class GamePlayState implements IState
{
	private var gameMode:StateMachine;
	private var game:Sprite;

	public function new(sm:StateMachine, sprite:Sprite)
	{
		gameMode = sm;
		game = sprite;
	}

	public function update(deltaTime:Float):Void
	{
		// code
	}

	public function render():Void
	{
		// code
	}

	public function onEnter(?param:Dynamic):Void
	{
		drawBoard();
	}

	public function onExit():Void
	{
		// code
	}

	private function drawBoard():Void
	{
		var center:Point = new Point(game.stage.stageWidth * .5, game.stage.stageHeight * .5);
		var positions:Array<Position> = [
			{startX: center.x - 150, startY: center.y - 50, endX: center.x + 150, endY: center.y - 50},
			{startX: center.x - 150, startY: center.y + 50, endX: center.x + 150, endY: center.y + 50},
			{startX: center.x - 50, startY: center.y - 150, endX: center.x - 50, endY: center.y + 150},
			{startX: center.x + 50, startY: center.y - 150, endX: center.x + 50, endY: center.y + 150}
		];

		var duration:UInt = 2;
		var thickness:UInt = 10;
		var color:UInt = 0xFF0000;
		var animationDelay:Float = .5;

		var i:Int = 0;
		for (p in positions)
		{
			var line:Line = new Line(p.startX, p.startY, p.endX, p.endY, duration, thickness, color, animationDelay * i);
			if (i == positions.length - 1) line.onAnimationComplete(onAnimationComplete);
			game.addChild(line);
			i++;
		}
	}

	private function onAnimationComplete():Void
	{
		game.addChild(new Cross(game.stage.stageWidth * .5 - 50, game.stage.stageHeight * .5 - 50));
	}
}