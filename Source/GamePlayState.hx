package;

import entities.Circle;
import entities.Board;
import entities.Cross;
import entities.Line;
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
	public var left:UInt;
	
	private var size:Float;
	private var tiles:Array<Tile>;
	private var winCombos:Array<Array<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]];
	
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
		left = 10;
		
		size = Math.min(game.stage.stageWidth, game.stage.stageHeight) * .8;
		game.addChild(new Board(game.stage.stageWidth * .5, game.stage.stageHeight * .5, size, addTiles));
		
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
				var tile:Tile = new Tile(xOffset + size / 3 * x, yOffset + size / 3 * y, size / 3, this);
				game.addChild(tile);
				tiles.push(tile);
				tile.addEventListener("TILE_ACTIVE", nextTurn);
			}
		}
	}
	
	public function nextTurn(e = null):Void
	{
		if (!winCheck())
		{
			left--;
			if (left > 0)
			{
				turn++;
			}
			else
			{
				endGame();
			}
		}
	}
	
	private function winCheck():Bool
	{
		var won:Bool = false;
		for (combo in winCombos)
		{
			var crossWin = true;
			var circleWin = true;
			for (tile in combo)
			{
				crossWin = crossWin && tiles[tile].isSet == "X";
				circleWin = circleWin && tiles[tile].isSet == "O";
			}
			
			if (crossWin || circleWin)
			{
				endGame(combo);
				won = true;
				break;
			} 
			else
			{
				won = false;
			}
		}
		
		return won;  
	}
	
	private function endGame(combo:Array<Int> = null):Void
	{
		var curPos:Int = 0;
		var won:Bool = combo != null;
		
		var startX:Float = 0;
		var startY:Float = 0;
		var endX:Float = 0;
		var endY:Float = 0;
		
		for (i in 0...tiles.length)
		{
			tiles[i].removeButtonListeners();
			if (won)
			{
				for (j in combo)
				{             
					if (i == j)
					{
						switch(curPos)
						{
							case 0:
								startX = tiles[i].x + tiles[i].width * .5;
								startY = tiles[i].y + tiles[i].height * .5;
								curPos++;
							case 1:
								curPos++;
							case 2:
								endX = tiles[i].x + tiles[i].width * .5;
								endY = tiles[i].y + tiles[i].height * .5;
						}
					}
				}
			}
		}
		
		if (won) game.addChild(new Line(startX, startY, endX, endY, 10, 0xFF80FF, true, 1, 1));
	}
	
	public function onExit():Void
	{
		// code
	}
}