package;

import haxe.Timer;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.Lib;
import openfl.events.Event;

/**
 * Main class for init.
 * @author Reinier de Vries
 */

class Main extends Sprite
{
	private var initialized:Bool;
	private var previousTime:Int;
	private var gameMode:StateMachine;

	private function resize(e)
	{
		if (!initialized) init();
		// else change orientation or resize
	}

	private function init()
	{
		if (initialized) return;
		initialized = true;
		
		createStateMachine();
	}

	function createStateMachine()
	{
		gameMode = new StateMachine();
		
		gameMode.add("mainmenu", new MainMenuState(gameMode, this));
		gameMode.add("gameplay", new GamePlayState(gameMode, this));
		gameMode.add("gameover", new GameOverState(gameMode, this));
		
		previousTime = Lib.getTimer();
		
		addEventListener(Event.ENTER_FRAME, update);
		
		gameMode.change("gameplay", 2);
	}

	function update(e)
	{
		var currentTime = Lib.getTimer();
		var deltaTime = 0.001 * (currentTime - previousTime);
		previousTime = Lib.getTimer();
		
		gameMode.update(deltaTime);
		gameMode.render();
	}

	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	private function added(e)
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}

	public static function main()
	{
		// Static entry point
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}