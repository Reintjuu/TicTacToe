package;

import entities.Circle;
import entities.Board;
import entities.Cross;
import entities.Tile;
import openfl.geom.Point;
import openfl.display.Sprite;

/**
 * State where all the game magic happens.
 * @author Reinier de Vries
*/

class GamePlayState implements IState
{
	private var gameMode:StateMachine;
	private var game:Sprite;
	
	public var playerAmount:UInt;
	public var turn:UInt;
	
	private var size:Float;
	private var tiles:Array<Tile>;
	
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
		playerAmount = param;
		turn = 0;
		
		size = game.stage.stageHeight * .8;
		game.addChild(new Board(game.stage.stageWidth * .5, game.stage.stageHeight * .5, size, onAnimationComplete));
	}

	private function onAnimationComplete():Void
	{
		//game.addChild(new Cross(game.stage.stageWidth * .5 - 50, game.stage.stageHeight * .5 - 50, 100, 10, 0x00FF00, .5));
		//game.addChild(new Circle(game.stage.stageWidth * .5 - 50, game.stage.stageHeight * .5 - 50, 50, 10, 0x0000FF, 2));
		
		addTiles();
	}
	
	private function addTiles():Void
	{
		tiles = new Array();
		var xOffset:Float = game.stage.stageWidth * .5 - size * .5;
		var yOffset:Float = game.stage.stageHeight * .5 - size * .5;
		for (y in 0...3)
		{
			for (x in 0...3)
			{
				var tile:Tile = new Tile(xOffset + size / 3 * x, yOffset + size / 3 * y, size / 3);
				game.addChild(tile);
				tiles.push(tile);
				tile.addEventListener("TILE_ACTIVE", nextTurn);
			}
		}
	}
	
	public function nextTurn(e):Void
	{
		trace("Next turn.");
		turn++;
	}
	
	public function onExit():Void
	{
		// code
	}
}