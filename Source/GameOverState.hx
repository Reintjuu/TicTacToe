package;

import openfl.display.Sprite;

/**
 * Game over state.
 * @author Reinier de Vries
 */
class GameOverState implements IState
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
		// code
	}

	public function onExit():Void
	{
		// code
	}
}