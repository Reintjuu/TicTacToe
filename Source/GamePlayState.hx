package;

import entities.Board;
import entities.Cross;
import UInt;
import openfl.geom.Point;
import entities.Line;
import openfl.display.Sprite;

/**
 * State where all the game magic happens.
 * @author Reinier de Vries
*/

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
		game.addChild(new Board(center.x, center.y, 300, onAnimationComplete));
	}

	private function onAnimationComplete():Void
	{
		game.addChild(new Cross(game.stage.stageWidth * .5 - 50, game.stage.stageHeight * .5 - 50, 100));
	}
}